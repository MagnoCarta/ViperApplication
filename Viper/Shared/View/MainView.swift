//
//  View.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI


struct MainView: View {
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let height: CGFloat = 150
    @ObservedObject var presenter: MainViewPresenter
    
    var body: some View {
        //NavigationView {
        ScrollView {
            // 4. Populate into grid
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(presenter.endpointNames,id:\.self) { endpoint in
                    let interactor = EndpointCardInteractor(nome: endpoint)
                    let endpointPresenter = EndpointCardPresenter(interactor: interactor)
                    self.presenter.linkBuilder(for: endpoint, content: {
                        EndpointCard(presenter: endpointPresenter)
                           
                    })
                    .frame(height: height)
                }
            }
            .padding()
        }
       // }
    }
}
