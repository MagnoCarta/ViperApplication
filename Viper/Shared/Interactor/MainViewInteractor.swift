//
//  MainViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class MainViewInteractor {
    
    var endpointNames: [Endpoint] = []
    var presenter: MainViewPresenter?
    
    func fetchEndpoints(endpoints: [Endpoint]) {
        self.endpointNames = endpoints
        self.presenter?.hasFetchedNames()
    }
    
}
