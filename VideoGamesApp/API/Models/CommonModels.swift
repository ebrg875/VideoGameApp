//
//  CommonModels.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: Platform
    let releasedAt: String?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
    }
}

// MARK: - Platform
struct Platform: Codable {
    let id: Int
    let name, slug: String
    let image: String?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let count: Int
    let percent: Double
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let url: String
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}
