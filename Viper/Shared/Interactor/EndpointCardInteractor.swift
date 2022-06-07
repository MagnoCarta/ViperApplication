//
//  EndpointCardInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation

class EndpointCardInteractor {
    
    let endpoint: Endpoint
    var name: String?
    var imageURL: String?
    weak var presenter: EndpointCardPresenter?
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
        self.name = endpoint.rawValue
    }
    
    init(endpoint: Endpoint,name: String,imageURL: String) {
        self.endpoint = endpoint
        fetchImageAndName(name: name, imageURL: imageURL)
    }
    
    func fetchImageAndName(name: String,imageURL: String) {
        self.imageURL = imageURL
        self.name = name
        presenter?.fetchedNamesAndImages()
    }
    
}
