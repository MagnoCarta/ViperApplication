//
//  DetailView.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailViewPresenter
    
    var body: some View {
        Button(presenter.endpointName, action: {
            IGDBWorker().loadEndpointInfo(endpoint: presenter.endpointName)
        })
    }
    
}
