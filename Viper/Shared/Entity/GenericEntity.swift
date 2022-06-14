//
//  GenericEntity.swift
//  Viper
//
//  Created by Gilberto vieira on 01/06/22.
//

import Foundation

struct GenericEntity: StructDecoder, Hashable {
    static var entityName: String = "Generic"
    
    let endpoint: Endpoint
    let id: Int?
    let name: String?
    let textDescription: String?
    let imageID: Int?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case endpoint
        case id
        case name
        case description
        case summary
        case textDescription
        case mugShot = "mug_shot"
        case logo
        case cover
        case platformLogo = "platform_logo"
        case imageID
        case imageURL = "url"
    }
}

extension GenericEntity: Codable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        endpoint = Endpoint(rawValue: try values.decode(String.self, forKey: .endpoint))!
        id = try values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
        imageURL = try? values.decode(String.self, forKey: .imageURL)
        switch endpoint {
        case .character:
            textDescription = try? values.decode(String.self, forKey: .description)
            imageID = try? values.decode(Int.self, forKey: .mugShot)
        case .company:
            textDescription = try? values.decode(String.self, forKey: .description)
            imageID = try? values.decode(Int.self, forKey: .logo)
        case .game:
            textDescription = try? values.decode(String.self, forKey: .summary)
            imageID = try? values.decode(Int.self, forKey: .cover)
        case .platform:
            textDescription = try? values.decode(String.self, forKey: .summary)
            imageID = try? values.decode(Int.self, forKey: .platformLogo)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(endpoint.rawValue, forKey: .endpoint)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(textDescription, forKey: .textDescription)
        try container.encode(imageID, forKey: .imageID)
        try container.encode(imageURL, forKey: .imageURL)
    }
}
