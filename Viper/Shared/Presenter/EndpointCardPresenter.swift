//
//  EndpointCardPresenter.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class EndpointCardPresenter: ObservableObject {
    
    
    private let interactor: EndpointCardInteractor
    let endpointName: String
    //private let router = EndpointRouter()
    
    init(interactor: EndpointCardInteractor) {
        self.interactor = interactor
        self.endpointName = interactor.nome
    }
}
