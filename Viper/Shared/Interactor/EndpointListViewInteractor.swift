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
            var trueSummary: [SummaryEntity] = []
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
            summary.forEach {summary in
                trueSummary.append(SummaryEntity(originalEntity: self.endpoint.imageType.rawValue, name: summary.0, imageURL: nil))
            }
            IGDBService.service.loadEndpointSummary(endpoint: self.endpoint, completion: {trueResult in
                var index = 0
                (trueResult as! [SummaryEntity]).forEach { actualSummary in
                    trueSummary[index].imageURL = actualSummary.imageURL
                    index += 1
                }
            })
            self.presenter?.hasFetchedSummary(summary: trueSummary)
        })
        
    }
    
}
