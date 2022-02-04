//
//  GamesListAdapter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
import RxSwift

protocol GamesListAdapterProtocol {
    func getGames(onSuccess: @escaping ([UIGameEntity]) -> Void,
                  onError: @escaping (Error) -> Void) -> Disposable
}

class GamesListAdapter: BaseAdapter, GamesListAdapterProtocol {

    let gamesEndpoint: GamesEndpointProtocol

    init(gamesEndpoint: GamesEndpointProtocol) {
        self.gamesEndpoint = gamesEndpoint
    }

    func getGames(onSuccess: @escaping ([UIGameEntity]) -> Void,
                  onError: @escaping (Error) -> Void)
        -> Disposable {
            return call(single: self.gamesEndpoint.getGames(),
                        converter: GamesListConverter.createGamesList(model:), //** move the mappers to the use cases?
                        onSuccess: onSuccess,
                        onError: onError)
    }
}
