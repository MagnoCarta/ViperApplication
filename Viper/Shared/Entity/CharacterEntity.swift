//
//  CharacterEntity.swift
//  Viper
//
//  Created by Gilberto vieira on 31/05/22.
//


import Foundation

// MARK: - CharacterEntity
struct CharacterEntity: Codable, StructDecoder {
    static var EntityName:String  = "CharacterEntity"
    
    let id, createdAt: Int
    let games: [Int]?
    let name, slug: String
    let updatedAt: Int
    let url: String
    let checksum: String
    let gender, mugShot, species: Int?
    let characterDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case games, name, slug
        case updatedAt = "updated_at"
        case url, checksum, gender
        case mugShot = "mug_shot"
        case species
        case characterDescription = "description"
    }
}

typealias Character = [CharacterEntity]
