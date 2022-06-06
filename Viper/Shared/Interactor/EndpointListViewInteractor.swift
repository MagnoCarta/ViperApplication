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
        IGDBService.service.loadEndpointSummary(endpoint: endpoint, completion: {result in
            var summary: [(String?, Int?)]
            switch self.endpoint {
            case .character:
                let characters = result as! [CharacterEntity]
                summary = characters.map({ ($0.name, $0.mugShot) })
            case .company:
                let companies = result as! [CompanyEntity]
                summary = companies.map({ ($0.name, $0.logo) })
            case .game:
                let games = result as! [GameEntity]
                summary = games.map({ ($0.name, $0.cover) })
            case .platform:
                let platforms = result as! [PlatformEntity]
                summary = platforms.map({ ($0.name, $0.platformLogo) })
            }
            self.presenter?.hasFetchedSummary(summary: summary)
        })
        
    }
    
}
