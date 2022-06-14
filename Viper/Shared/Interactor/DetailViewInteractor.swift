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
    var endpointEntity: GenericEntity?
    weak var presenter: DetailViewPresenter?
    
    func setEndpoint(endpoint: Endpoint, summary: GenericEntity) {
        self.endpoint = endpoint
        self.endpointEntity = summary
        presenter?.hasFetchedEntity()
    }
    
}
