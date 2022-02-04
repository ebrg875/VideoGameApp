//
//  GameDetailEndpoint.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import RxSwift

protocol GameDetailEndpointProtocol {
    func getGameDetail<T>(id: Int) -> Single<T> where T: GameDetailResponse
}

class GameDetailEndpoint: BaseEndpoint, GameDetailEndpointProtocol {
    func getGameDetail<T>(id: Int) -> Single<T> where T: GameDetailResponse {
        let req = BaseRequest(Endpoint.gameDetail(id: id).getPath())
        return super.request(model: req)
    }
}
