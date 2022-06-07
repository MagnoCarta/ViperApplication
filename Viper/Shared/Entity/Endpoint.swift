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
    var imageType: (EndpointImage,String) {
        switch self {
        case .character:
            return (EndpointImage.mugshot,"mug_shot")
        case .company:
            return (EndpointImage.logo,"logo")
        case .game:
            return (EndpointImage.cover,"cover")
        case .platform:
            return (EndpointImage.platformLogo,"platform_logo")
        }
    }
    
    var endPointFetched: Bool {
        false
    }
    
}

enum EndpointImage: String {
    case mugshot = "character_mug_shot",logo = "company_logo",cover,platformLogo = "platform_logo"
}
