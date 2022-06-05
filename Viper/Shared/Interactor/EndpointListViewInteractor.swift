//
//  EndpointListViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class EndpointListViewInteractor {
    
    let endpoint: Endpoint
    var names: [String?] = []
    var urlImages: [String?] = []
    var presenter: EndpointListViewPresenter?
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func fetchNames() {
        IGDBService.service.loadEndpointSummary(endpoint: endpoint, completion: {result in
            
            switch self.endpoint {
            case .character:
                print((result as! [CharacterEntity]).first?.name)
            case .company:
                print((result as! [CompanyEntity]).first?.name)
            case .game:
                print((result as! [GameEntity]).first?.name)
            case .platform:
                print((result as! [PlatformEntity]).first?.name)
            }
        })
        
        presenter?.hasFetchedSummary()
        
    }
    
    func getUrlImages() {
        
        
    }
    
}
