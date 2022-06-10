//
//  EndpointCardInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation

class EndpointCardInteractor {
    
    var endpoint: Endpoint = Endpoint.character
    var name: String?
    var imageURL: String?
    weak var presenter: EndpointCardPresenter?
    
    func fetchCard(endpoint: Endpoint,name: String,imageURL:String) {
        self.imageURL = imageURL
        self.name = name
        self.endpoint = endpoint
        presenter?.hasFetched()
    }
}
