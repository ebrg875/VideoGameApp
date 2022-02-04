//
//  GameDetailResponse.swift
//  VideoGamesApp
//
//  Created by emeksu.barug on 4.02.2022.
//

import Foundation

// MARK: - GameDetailResponse
class GameDetailResponse: Codable {
    let id: Int
    let slug, name, nameOriginal, gameDetailResponseDescription: String
    let metacritic: Int?
    let metacriticPlatforms: [MetacriticPlatform]
    let released: String
    let tba: Bool
    let updated: String
    let backgroundImage, backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let added: Int
    let addedByStatus: AddedByStatus
    let playtime, screenshotsCount, moviesCount, creatorsCount: Int
    let achievementsCount, parentAchievementsCount: Int
    let redditURL, redditName, redditDescription, redditLogo: String
    let redditCount, twitchCount, youtubeCount, reviewsTextCount: Int
    let ratingsCount, suggestionsCount: Int
    let metacriticURL: String
    let parentsCount, additionsCount, gameSeriesCount: Int
    let reviewsCount: Int
    let parentPlatforms: [ParentPlatform]
    let platforms: [PlatformElement]
    let esrbRating: EsrbRating
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id , slug, name
        case nameOriginal = "name_original"
        case gameDetailResponseDescription = "description"
        case metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case ratings, added
        case addedByStatus = "added_by_status"
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditURL = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case metacriticURL = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case reviewsCount = "reviews_count"
        case parentPlatforms = "parent_platforms"
        case platforms
        case esrbRating = "esrb_rating"
        case descriptionRaw = "description_raw"
    }
}

// MARK: - MetacriticPlatform
struct MetacriticPlatform: Codable {
    let metascore: Int?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case metascore, url
    }
}
