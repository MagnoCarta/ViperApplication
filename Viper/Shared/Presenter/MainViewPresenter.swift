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
    let endpointNames: [Endpoint]
    private let router: MainViewRouter = MainViewRouter()
    
    init(interactor: MainViewInteractor) {
        self.interactor = interactor
        self.endpointNames = interactor.nomes
    }
    
}
