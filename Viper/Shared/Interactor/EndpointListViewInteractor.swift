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
        if summaries.count == 0 {
            summaries = CoreDataService.service.getEntities(endpoint: endpoint)
            if !summaries.isEmpty {
                self.presenter?.hasFetched()
                self.page = (self.summaries.count / IGDBService.requestCount)
                print(summaries.count)
            } else {
                fetchFromAPI()
            }
        }
        else {
            fetchFromAPI()
        }
    }
    
    func fetchFromAPI() {
        IGDBService.service.loadEndpointWithDefaultFields(endpoint: endpoint, page: page, completion: { result in
            let entities = result as! [GenericEntity]
            self.summaries.append(contentsOf: entities)
            CoreDataService.service.saveEntities(entities: self.summaries)
            self.page = (self.summaries.count / IGDBService.requestCount)
            self.presenter?.hasFetched()
        })
    }
    
    func loadMoreContentIfNeeded(summary: GenericEntity?) {
        let loadedSummary = self.summaries.last
        if loadedSummary == summary {
            self.fetchSummary()
        }
    }
    
    func fetchEndpoint(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
}
