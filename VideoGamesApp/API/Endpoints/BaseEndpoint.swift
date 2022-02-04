//
//  BaseEndpoint.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import RxSwift
import Alamofire

enum Endpoint {
    case games
    case gameDetail(id: Int)

    func getPath() -> String {
        switch self {
        case .games:
            return "/games"
        case .gameDetail(let id):
            return "/games/\(id)"
        }
    }
}

protocol BaseEndpointProtocol {
    func request<T: Decodable>(model: BaseRequest) -> Single<T>
}

class BaseEndpoint: BaseEndpointProtocol {
    
    func request<T>(model: BaseRequest) -> Single<T> where T: Decodable {
        return Observable.create { observer in
            
            guard let url = model.url else {
                observer.onError(ServiceError.invalidUrl) // define custom error type
                return Disposables.create()
            }
            
            let req = AF.request(url,
                                 method: HTTPMethod.init(rawValue: model.method ?? "GET"),
                                 parameters: model.parameters,
                                 headers: HTTPHeaders.default)
            req.responseJSON { (response) in
                switch response.result {
                case .success :
                    do {
                        let model = try JSONDecoder().decode(T.self, from: response.data!)
                        observer.onNext(model)
                        observer.onCompleted()
                    } catch {
                        observer.onError(ServiceError.invalidJson)
                    }
                case .failure :
                    observer.onError(ServiceError.invalidRequest)
                }
            }
            return Disposables.create()
        }.asSingle()
    }
}

enum ServiceError: Error {
    case invalidUrl
    case invalidJson
    case invalidRequest
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return NSLocalizedString("Nil or invalid request URL", comment: "Invalid URL")
        case .invalidJson:
            return NSLocalizedString("Error encountered while parsing JSON response", comment: "Invalid JSON")
        case .invalidRequest:
            return NSLocalizedString("Error encountered while sending API request", comment: "Invalid Request")
        }
    }
}
