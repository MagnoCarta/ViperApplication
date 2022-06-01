//
//  EntityType.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 31/05/22.
//

import Foundation

enum Endpoint: String, CaseIterable {
    case character, company, game, platform
    
    func getArrayType() -> Any.Type {
        switch self {
        case .character:
            return [CharacterEntity].self
        case .company:
            return [CompanyEntity].self
        case .game:
            return [GameEntity].self
        case .platform:
            return [PlatformEntity].self
        }
    }
    
    static func getEndpointFromArrayType<T>(type: T) -> Endpoint? {
        switch type {
        case is [CharacterEntity]:
            return .character
        case is [CompanyEntity]:
            return .company
        case is [GameEntity]:
            return .game
        case is [PlatformEntity]:
            return .platform
        default:
            return nil
        }
    }
}
