//
//  EndpointListViewPresenter.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation

class EndpointListViewPresenter: ObservableObject {
    
    private let interactor: EndpointListViewInteractor
    let endpointName: Endpoint
    var view: EndpointListView?
    
    init(interactor: EndpointListViewInteractor) {
        self.interactor = interactor
        self.endpointName = interactor.endpoint
        
        interactor.presenter = self
    }
    
    func fetchSummary() {
        interactor.fetchSummary()
    }
    
    func hasFetchedSummary(summary: [SummaryEntity]) {
        view?.summary = summary
    }
    
//    func moveToEndpointListView(endpoint: Endpoint) -> EndpointListView {
//        return router.makeEndpointListView(for: endpoint)
//    }
    
    
}
