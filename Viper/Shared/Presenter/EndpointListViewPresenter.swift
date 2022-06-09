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
    @Published var updateToggle: Bool = false
    
    init(interactor: EndpointListViewInteractor) {
        self.interactor = interactor
        self.endpointName = interactor.endpoint
        
        interactor.presenter = self
    }
    
    func fetchSummary() {
        interactor.fetchSummary()
    }
    
    func hasFetchedSummary() {
        updateToggle = !updateToggle
    }
    
    func moveToDetailView(name: String) -> DetailView {
        return router.makeDetailView(endpoint: endpointName,for: name)
    }
    
    func changePageIfNeeded(summary: SummaryEntity?) {
        interactor.loadMoreContentIfNeeded(summary: summary)
    }
    
    func getSummaries() -> [SummaryEntity] {
        return interactor.summaries
    }
    
    
    
    
}
