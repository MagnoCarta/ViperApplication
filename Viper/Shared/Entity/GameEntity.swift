//
//  GameEntity.swift
//  Viper
//
//  Created by Gilberto vieira on 31/05/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let game = try? newJSONDecoder().decode(Game.self, from: jsonData)

import Foundation

// MARK: - GameEntity
struct GameEntity: Codable, StructDecoder {
    static var entityName: String = "Game"
    
    let id, category: Int
    let cover: Int?
    let createdAt: Int
    let externalGames: [Int]?
    let firstReleaseDate: Int?
    let gameModes, genres: [Int]?
    let name: String
    let platforms, releaseDates, screenshots, similarGames: [Int]?
    let slug: String
    let status: Int?
    let summary: String?
    let tags, themes: [Int]?
    let updatedAt: Int
    let url: String
    let websites: [Int]?
    let checksum: String
    let ageRatings, involvedCompanies, alternativeNames: [Int]?
    let parentGame: Int?
    let aggregatedRating: Double?
    let aggregatedRatingCount: Int?
    let bundles: [Int]?
    let collection, franchise: Int?
    let franchises, keywords: [Int]?
    let rating: Double?
    let ratingCount: Int?
    let totalRating: Double?
    let totalRatingCount: Int?
    let gameEngines, playerPerspectives, artworks, videos: [Int]?
    let storyline: String?
    let versionParent: Int?
    let versionTitle: String?
    let hypes, follows: Int?
    let multiplayerModes, dlcs, standaloneExpansions, remasters: [Int]?

    enum CodingKeys: String, CodingKey {
        case id, category, cover
        case createdAt = "created_at"
        case externalGames = "external_games"
        case firstReleaseDate = "first_release_date"
        case gameModes = "game_modes"
        case genres, name, platforms
        case releaseDates = "release_dates"
        case screenshots
        case similarGames = "similar_games"
        case slug, status, summary, tags, themes
        case updatedAt = "updated_at"
        case url, websites, checksum
        case ageRatings = "age_ratings"
        case involvedCompanies = "involved_companies"
        case alternativeNames = "alternative_names"
        case parentGame = "parent_game"
        case aggregatedRating = "aggregated_rating"
        case aggregatedRatingCount = "aggregated_rating_count"
        case bundles, collection, franchise, franchises, keywords, rating
        case ratingCount = "rating_count"
        case totalRating = "total_rating"
        case totalRatingCount = "total_rating_count"
        case gameEngines = "game_engines"
        case playerPerspectives = "player_perspectives"
        case artworks, videos, storyline
        case versionParent = "version_parent"
        case versionTitle = "version_title"
        case hypes, follows
        case multiplayerModes = "multiplayer_modes"
        case dlcs
        case standaloneExpansions = "standalone_expansions"
        case remasters
    }
}
