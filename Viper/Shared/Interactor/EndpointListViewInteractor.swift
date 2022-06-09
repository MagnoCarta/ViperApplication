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
    var page: Int = 0
    var summaries: [SummaryEntity] = []
    weak var presenter: EndpointListViewPresenter?
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func fetchSummary() {
        var summary: [(String?, Int?)] = []
        var trueSummary: [SummaryEntity] = []
        IGDBService.service.loadEndpointSummary(endpoint: endpoint,page: page, completion: { result in
            
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
            self.summaries.append(contentsOf: trueSummary)
            self.presenter?.hasFetchedSummary()
        })

    }
    
    
    func loadMoreContentIfNeeded(summary: SummaryEntity?) {
        let loadedSummary = self.summaries.last
        if loadedSummary == summary {
            self.fetchSummary()
            page += 1
        }
//        if summary == nil {
//            self.fetchSummary()
//            page += 1
//        }
        
    }
    
}
