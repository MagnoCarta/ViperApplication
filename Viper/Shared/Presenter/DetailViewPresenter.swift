//
//  DetailViewPresenter.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation

class DetailViewPresenter: ObservableObject {
    
    
    private let interactor: DetailViewInteractor
    let endpointName: Endpoint
    
    init(interactor: DetailViewInteractor) {
        self.interactor = interactor
        self.endpointName = interactor.endpoint
    }
}
