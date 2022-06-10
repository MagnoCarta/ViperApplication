//
//  DetailViewInteractor.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 05/06/22.
//

import Foundation
import SwiftUI

class DetailViewInteractor {
    
    var endpoint: Endpoint = Endpoint.character
    var name: String = "Default Name"
    var endpointEntity: GenericEntity?
    weak var presenter: DetailViewPresenter?
    
    func fetchEndpointAndName(endpoint: Endpoint,name: String) {
        self.endpoint = endpoint
        self.name = name
        fetchEntity()
    }
    
    func fetchEntity() {
        let postString = "fields *; where name = \"\(name)\";"
        IGDBService.service.loadEndpointsWithFields(endpoint: endpoint, fields: postString) { result in
            self.endpointEntity = (result as! [GenericEntity]).first
            self.presenter?.hasFetchedEntity()
        }
    }
    
}
