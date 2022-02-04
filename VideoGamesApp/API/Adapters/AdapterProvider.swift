//
//  AdapterProvider.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation
class AdapterProvider {
    static let getGamesListAdapter: GamesListAdapterProtocol = GamesListAdapter(gamesEndpoint: EndpointProvider.gamesEndpoint)
    static let getGameDetailAdapter: GameDetailAdapterProtocol = GameDetailAdapter(gameDetailEndpoint: EndpointProvider.gameDetailEndpoint)
}
