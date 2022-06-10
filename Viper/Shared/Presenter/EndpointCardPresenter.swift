//
//  EndpointCardPresenter.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class EndpointCardPresenter: ObservableObject {
    
    // MARK: Variables
    private var interactor: EndpointCardInteractor?
    let endpointName: Endpoint = Endpoint.character
    var view: EndpointCard?
    @Published var updateToggle: Bool = false
    //private let router = EndpointRouter()
    
    // MARK: Init Interactor
    init(interactor: EndpointCardInteractor) {
        self.interactor = interactor
        interactor.presenter = self
    }
    
    // MARK: Get Functions
    func getName() -> String {
        interactor?.name ?? "No Name"
    }
    
    func getImageURL() -> String {
        guard let imageURL = interactor?.imageURL else { return "" }
        return imageURL
    }
    
    // MARK: Fetch Functions
    func hasFetched() {
        updateToggle = !updateToggle
    }
    
    func fetchCard(endpoint: Endpoint,name: String, imageURL: String) {
        self.interactor?.fetchCard(endpoint: endpoint, name: name, imageURL: imageURL)
    }
   
    
}
