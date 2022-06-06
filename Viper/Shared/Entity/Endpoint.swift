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
    var imageType: EndpointImage {
        switch self {
        case .character:
            return EndpointImage.mugshot
        case .company:
            return EndpointImage.logo
        case .game:
            return EndpointImage.cover
        case .platform:
            return EndpointImage.platformLogo
        }
    }
    
    var endPointFetched: Bool {
        false
    }
    
}

enum EndpointImage: String {
    case mugshot = "mug_shot",logo,cover,platformLogo = "platform_logo"
}
