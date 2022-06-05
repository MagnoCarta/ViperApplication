//
//  EndpointListViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation

class EndpointListViewInteractor {
    
    let endpoint: Endpoint
    var results: [StructDecoder] = []
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
}
