//
//  EndpointListViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class EndpointListViewInteractor {
    
    let endpoint: Endpoint
    var names: [String?] = []
    var urlImages: [String?] = []
    weak var presenter: EndpointListViewPresenter?
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func fetchSummary() {
        var summary: [(String?, Int?)] = []
        var trueSummary: [SummaryEntity] = []
        IGDBService.service.loadEndpointSummary(endpoint: endpoint, completion: { result in
            
            switch self.endpoint {
            case .character:
                let characters = result as! [CharacterEntity]
                trueSummary = characters.map({character in
                    SummaryEntity(originalEntity: self.endpoint.rawValue, name: character.name, imageURL: character.mugShotURL)
                })
            case .company:
                let companies = result as! [CompanyEntity]
                trueSummary = companies.map({company in
                    SummaryEntity(originalEntity: self.endpoint.rawValue, name: company.name, imageURL: company.logoURL)
                })
            case .game:
                let games = result as! [GameEntity]
                trueSummary = games.map({game in
                    SummaryEntity(originalEntity: self.endpoint.rawValue, name: game.name, imageURL: game.coverURL)
                })
            case .platform:
                let platforms = result as! [PlatformEntity]
                trueSummary = platforms.map({platform in
                    SummaryEntity(originalEntity: self.endpoint.rawValue, name: platform.name, imageURL: platform.platformLogoURL)
                })
            }
            
            self.presenter?.hasFetchedSummary(summary: trueSummary)
        })

    }
    
}
