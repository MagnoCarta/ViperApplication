//
//  EndpointListViewPresenter.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation

class EndpointListViewPresenter: ObservableObject {
    
    // MARK: Variables
    private var interactor: EndpointListViewInteractor
    private let router: EndpointListViewRouter = EndpointListViewRouter()
    var endpointName: Endpoint = Endpoint.character
    var view: EndpointListView?
    @Published var updateToggle: Bool = false
    
    // MARK: Init with an Interactor
    init(interactor: EndpointListViewInteractor) {
        self.interactor = interactor
        interactor.presenter = self
    }
    
    // MARK: Get Functions
    func getSummaries() -> [SummaryEntity] {
        interactor.summaries
    }
    
    func getEndpoint() -> Endpoint {
        interactor.endpoint
    }
    
    // MARK: Fetch Functions
    func fetchEndpoint(endpoint: Endpoint) {
        interactor.fetchEndpoint(endpoint: endpoint)
    }

    func fetchSummary() {
        interactor.fetchSummary()
    }
        
    func hasFetched() {
        DispatchQueue.main.async {
            self.updateToggle = !self.updateToggle
        }
    }
    
    // MARK: Router
    func moveToDetailView(name: String) -> DetailView {
        return router.makeDetailView(endpoint: endpointName,for: name)
    }
    
    // MARK: Pagination
    func changePageIfNeeded(summary: SummaryEntity?) {
        interactor.loadMoreContentIfNeeded(summary: summary)
    }
}
