//
//  GamesListResponse.swift
//  VideoGameApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

// MARK: - GamesListResponse
class GamesListResponse: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
    let seoTitle, seoDescription, seoKeywords, seoH1: String
    let noindex, nofollow: Bool
    let gameResponseDescription: String
    let filters: Filters
    let nofollowCollections: [String]

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case gameResponseDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int
    let filter: String
    let decade: Int
    let years: [YearYear]
    let nofollow: Bool
    let count: Int
}

// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int
    let nofollow: Bool
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatus
    let metacritic, playtime, suggestionsCount: Int
    let updated: String
    let reviewsCount: Int
    let platforms: [PlatformElement]
    let parentPlatforms: [ParentPlatform]
    let genres: [Genre]
    let tags: [Genre]
    let esrbRating: EsrbRating
    let shortScreenshots: [ShortScreenshot]

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case language
    }
}

enum Language: String, Codable {
    case eng = "eng"
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

