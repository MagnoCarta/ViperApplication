//
//  EntityType.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 31/05/22.
//

import Foundation


enum Endpoint: String, CaseIterable {
    case character = "Character", company = "Company", game = "Game", platform = "Platform"
    
    func getImageField() -> String {
        switch self {
        case .character:
            return "mug_shot"
        case .company:
            return "logo"
        case .game:
            return "cover"
        case .platform:
            return "platform_logo"
        }
    }
}

