//
//  GamesListConverter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

class GamesListConverter {
    static func createGamesList(model: GamesListResponse) -> [UIGameEntity] {
        return model.results.map { game -> UIGameEntity in
            UIGameEntity(id: game.id,
                         name: game.name,
                         imageUrl: game.backgroundImage,
                         rating: game.rating,
                         released: game.released)
        }
    }
}
