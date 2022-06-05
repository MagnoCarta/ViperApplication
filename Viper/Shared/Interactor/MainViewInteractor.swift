//
//  MainViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class MainViewInteractor {
    
    let worker: IGDBService = IGDBService.worker
    let nomes: [Endpoint]
    //let presenter:
    
    init(nomes: [Endpoint]) {
        self.nomes = nomes
    }
    
}
