//
//  PlatformEntity.swift
//  Viper
//
//  Created by Gilberto vieira on 31/05/22.
//


import Foundation

// MARK: - PlatformEntity
struct PlatformEntity: Codable, StructDecoder {
    static var entityName: String = "Platform"
    
    let id: Int?
    let alternativeName: String?
    let category: Int?
    let createdAt: Int?
    let name: String?
    let platformLogo: Int?
    let slug: String?
    let updatedAt: Int?
    let url: String?
    let versions: [Int]?
    let websites: [Int]?
    let checksum: String?
    let generation, platformFamily: Int?
    let abbreviation, summary: String?

    enum CodingKeys: String, CodingKey {
        case id
        case alternativeName = "alternative_name"
        case category
        case createdAt = "created_at"
        case name
        case platformLogo = "platform_logo"
        case slug
        case updatedAt = "updated_at"
        case url, versions, websites, checksum, generation
        case platformFamily = "platform_family"
        case abbreviation, summary
    }
}
