//
//  GamesEndpoint.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import RxSwift

protocol GamesEndpointProtocol {
    func getGames<T>() -> Single<T> where T: GamesListResponse
}

class GamesEndpoint: BaseEndpoint, GamesEndpointProtocol {
    func getGames<T>() -> Single<T> where T: GamesListResponse {
        let req = BaseRequest(Endpoint.games.getPath())
        return super.request(model: req)
    }
}
