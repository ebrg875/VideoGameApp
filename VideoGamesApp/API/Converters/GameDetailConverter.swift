//
//  GameDetailConverter.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

class GameDetailConverter {
    static func createGameDetail(model: GameDetailResponse) -> UIGameDetailEntity {
        return UIGameDetailEntity(id: model.id,
                                  name: model.name,
                                  imageUrl: model.backgroundImage,
                                  metacriticRating: model.metacritic ?? 0,
                                  released: model.released,
                                  description: model.gameDetailResponseDescription)
    }
}
