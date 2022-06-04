//
//  ViperApp.swift
//  Shared
//
//  Created by Gilberto vieira on 26/05/22.
//

import SwiftUI

@main
struct ViperApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let interactor = MainViewInteractor(nomes: Endpoint.allCases)
            let presenter = MainViewPresenter(interactor: interactor)
            
            MainView(presenter: presenter)
        }
    }
}
