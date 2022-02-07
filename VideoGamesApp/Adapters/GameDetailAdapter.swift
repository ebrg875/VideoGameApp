//
//  GameDetailAdapter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import RxSwift

protocol GameDetailAdapterProtocol {
    func getGameDetail(gameId: Int,
                       onSuccess: @escaping (UIGameDetailEntity) -> Void,
                       onError: @escaping (Error) -> Void) -> Disposable
}

class GameDetailAdapter: BaseAdapter, GameDetailAdapterProtocol {

    let gameDetailEndpoint: GameDetailEndpointProtocol

    init(gameDetailEndpoint: GameDetailEndpointProtocol) {
        self.gameDetailEndpoint = gameDetailEndpoint
    }

    func getGameDetail(gameId: Int,
                       onSuccess: @escaping (UIGameDetailEntity) -> Void,
                       onError: @escaping (Error) -> Void)
        -> Disposable {
            return call(single: self.gameDetailEndpoint.getGameDetail(id: gameId),
                        converter: GameDetailConverter.createGameDetail(model:),
                        onSuccess: onSuccess,
                        onError: onError)
    }
}
