//
//  DetailViewInteractor.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 05/06/22.
//

import Foundation
import SwiftUI

class DetailViewInteractor {
    
    var name: String
    var urlImages: [String?] = []
    weak var presenter: DetailViewPresenter?
    
    init(name: String) {
        self.name = name
    }
    
    func fetchEntity() {
        var entity: StructDecoder
        
//        IGDBService.service.loadEndpointsWithFields(endpoint: <#T##Endpoint#>, fields: <#T##String#>, completion: <#T##(Any) -> Void#>)

    }
    
}
