//
//  FavouritesDefaultsModel.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 7.02.2022.
//

import Foundation

class FavouritesDefaultsModel: Codable {
    var favourites: [GameDefaultsModel]

    enum CodingKeys: String, CodingKey {
        case favourites
    }

    init(favourites: [GameDefaultsModel]) {
        self.favourites = favourites
    }
}

class GameDefaultsModel: Codable {
    var id: Int
    var name: String
    var rating: Double?
    var released: String?
    var imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, name, rating, released, imageUrl
    }

    init(id: Int, name: String, rating: Double?, released: String?, imageUrl: String?) {
        self.id = id
        self.name = name
        self.rating = rating
        self.released = released
        self.imageUrl = imageUrl
    }
}

