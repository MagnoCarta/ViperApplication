//
//  EndpointListViewPresenter.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation

class EndpointListViewPresenter: ObservableObject {
    
    private let interactor: EndpointListViewInteractor
    private let router: EndpointListViewRouter = EndpointListViewRouter()
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
    
    func hasFetchedSummary(summaries: [SummaryEntity]) {
        view?.summaries = summaries
    }
    
    func moveToDetailView(name: String) -> DetailView {
        return router.makeDetailView(endpoint: endpointName,for: name)
    }
    
    
}
