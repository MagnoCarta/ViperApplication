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
            MainView(endpoints: IGDBWorker().loadEndpoints())
                .frame(width: NSScreen.main?.frame.width, height: NSScreen.main?.frame.height, alignment: .center)
        }
    }
}
