//
//  FavouritesListConverter.swift
//  VideoGameApp
//
//  Created by emeksu.barug on 7.02.2022.
//

import Foundation

class FavouritesListConverter {
    static func createFavouritesList(model: FavouritesDefaultsModel) -> [UIGameEntity] {
        return model.favourites.map { game -> UIGameEntity in
            UIGameEntity(id: game.id,
                         name: game.name,
                         imageUrl: game.imageUrl ?? "",
                         rating: game.rating ?? 0,
                         released: game.released ?? "")
        }
    }

    static func createGameDefaultsModel(game: UIGameEntity) -> GameDefaultsModel {
        return GameDefaultsModel(id: game.id,
                                 name: game.name,
                                 rating: game.rating,
                                 released: game.released,
                                 imageUrl: game.imageUrl)
    }
}
