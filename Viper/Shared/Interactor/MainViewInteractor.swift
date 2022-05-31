//
//  MainViewInteractor.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

class MainViewInteractor {
    
    let worker: IGDBWorker = IGDBWorker.worker
    let nomes: [String]
    //let presenter:
    
    init(nomes: [String]) {
        self.nomes = nomes
    }
    
}
