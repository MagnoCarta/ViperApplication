//
//  Presenter.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation
import SwiftUI

class MainViewPresenter: ObservableObject {
    
    // MARK: Variables
    private var interactor: MainViewInteractor
    private let router: MainViewRouter = MainViewRouter()
    var view: MainView?
    @Published var updateToggle: Bool = false
    
    // MARK: Init Interactor
    init(interactor: MainViewInteractor) {
        self.interactor = interactor
        interactor.presenter = self
    }
    
    // MARK: Get Functions
    func getNames() -> [Endpoint] {
        self.interactor.endpointNames
    }
    
    func moveToEndpointListView(endpoint: Endpoint) -> EndpointListView {
        return router.makeEndpointListView(for: endpoint)
    }
    
    //MARK: Fetch Functions
    func fetchNames(endpoints: [Endpoint]) {
        interactor.fetchEndpoints(endpoints: endpoints)
    }
    
    func hasFetchedNames() {
        if !updateToggle {
            self.updateToggle = !self.updateToggle
        }
    }
}
