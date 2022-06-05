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
    private let view: MainView?
    
    init(interactor: MainViewInteractor) {
        self.interactor = interactor
    }
    
    func buildViewCells(endpoint: Endpoint) -> EndpointCard {
        return view.buildCells(endpoint: endpoint)
    }
    
    
    func getNames() -> [Endpoint] {
        self.interactor.nomes
    }
    
    func moveToDetailView(endpoint: Endpoint) -> DetailView {
        return router.makeDetailView(for: endpoint)
    }
    
}
