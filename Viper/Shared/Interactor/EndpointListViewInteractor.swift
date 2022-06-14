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
    var summaries: [GenericEntity] = []
    weak var presenter: EndpointListViewPresenter?

    func fetchSummary() {
        summaries = CoreDataService.service.getEntities(endpoint: endpoint)
        print(summaries)
        if summaries.count / IGDBService.requestCount <= page {
            IGDBService.service.loadEndpointWithDefaultFields(endpoint: endpoint, page: page, completion: { result in
                let entities = result as! [GenericEntity]
                self.summaries.append(contentsOf: entities)
                CoreDataService.service.saveEntities(entities: self.summaries)
                self.presenter?.hasFetched()
            })
        }
    }
    
    func loadMoreContentIfNeeded(summary: GenericEntity?) {
        let loadedSummary = self.summaries.last
        if loadedSummary == summary {
            self.fetchSummary()
            page += 1
        }
    }
    
    func fetchEndpoint(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
}
