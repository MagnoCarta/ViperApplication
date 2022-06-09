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
        var trueSummary: [SummaryEntity] = []
        IGDBService.service.loadEndpointSummary(endpoint: endpoint,page: page, completion: { result in
            
            let entities = result as! [GenericEntity]
            trueSummary = entities.map({entity in
                SummaryEntity(originalEntity: self.endpoint.rawValue, name: entity.name, imageURL: entity.imageURL)
            })
            
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
