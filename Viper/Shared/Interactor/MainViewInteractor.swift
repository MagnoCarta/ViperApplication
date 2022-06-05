//
//  MainViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class MainViewInteractor {
    
    let service: IGDBService = IGDBService.service
    let nomes: [Endpoint]
    
    init(nomes: [Endpoint]) {
        self.nomes = nomes
    }
    
}
