//
//  Presenter.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation
import SwiftUI

class MainViewPresenter: ObservableObject {
    
    private let interactor: MainViewInteractor
    private let router: MainViewRouter = MainViewRouter()
    
    init(interactor: MainViewInteractor) {
        self.interactor = interactor
    }
    
    func getNames() -> [Endpoint] {
        self.interactor.endpointNames
    }
    
    func moveToEndpointListView(endpoint: Endpoint) -> EndpointListView {
        return router.makeEndpointListView(for: endpoint)
    }
    
}
