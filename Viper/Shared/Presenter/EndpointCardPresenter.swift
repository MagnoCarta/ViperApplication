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
    let endpointName: Endpoint
    var view: EndpointCard?
    @Published var updateToggle: Bool = false

    //private let router = EndpointRouter()
    
    init(interactor: EndpointCardInteractor) {
        self.interactor = interactor
        self.endpointName = interactor.endpoint
        
        interactor.presenter = self
    }
    
    func getName() -> String {
        interactor.name ?? "No Name"
    }
    
    func getImageURL() -> String {
        guard let imageURL = interactor.imageURL else { return "" }
        return imageURL
    }
    
    func fetchedNamesAndImages() {
        updateToggle != updateToggle
    }
    
}
