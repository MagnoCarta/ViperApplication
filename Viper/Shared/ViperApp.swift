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
            createView()
                .preferredColorScheme(.dark)
        }
    }
    
    func createView() -> some View {
        let interactor = MainViewInteractor()
        let presenter = MainViewPresenter(interactor: interactor)
        presenter.fetchNames(endpoints: Endpoint.allCases)
        return MainView(presenter: presenter)
    }
}
