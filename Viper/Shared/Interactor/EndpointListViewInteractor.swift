//
//  EndpointListViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class EndpointListViewInteractor {
    
    var endpoint: Endpoint = Endpoint.character
    var page: Int = 0
    var summaries: [SummaryEntity] = []
    weak var presenter: EndpointListViewPresenter?

    func fetchSummary() {
        var trueSummary: [SummaryEntity] = []
        IGDBService.service.loadEndpointSummary(endpoint: endpoint,page: page, completion: { result in
            
            let entities = result as! [GenericEntity]
            trueSummary = entities.map({entity in
                SummaryEntity(originalEntity: self.endpoint.rawValue, name: entity.name, imageURL: entity.imageURL)
            })
            
            self.summaries.append(contentsOf: trueSummary)
            self.presenter?.hasFetched()
        })
        
    }
    
    func loadMoreContentIfNeeded(summary: SummaryEntity?) {
        let loadedSummary = self.summaries.last
        if loadedSummary == summary {
            self.fetchSummary()
            page += 1
        }
    }
    
    func fetchEndpoint(endpoint: Endpoint) {
        self.endpoint = endpoint
        self.fetchSummary()
    }
    
}
