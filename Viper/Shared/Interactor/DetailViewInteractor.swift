//
//  DetailViewInteractor.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 05/06/22.
//

import Foundation
import SwiftUI

class DetailViewInteractor {
    
    let endpoint: Endpoint
    var name: String
    var endpointEntity: GenericEntity?
    weak var presenter: DetailViewPresenter?
    
    init(endpoint: Endpoint, name: String) {
        self.endpoint = endpoint
        self.name = name
    }
    
    func fetchEntity() {
        let postString = "fields *; where name = \"\(name)\";"
        IGDBService.service.loadEndpointsWithFields(endpoint: endpoint, fields: postString) { result in
            self.endpointEntity = (result as! [GenericEntity]).first
            self.presenter?.hasFetchedEntity()
        }
    }
    
}
