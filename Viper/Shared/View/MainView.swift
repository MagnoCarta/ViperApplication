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
        
#if os(iOS)
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(presenter.getNames(),id:\.self) { endpoint in
                        NavigationLink {
                            presenter.moveToEndpointListView(endpoint: endpoint)
                        } label: {
                            buildCard(endpoint: endpoint)
                        }
                        .frame(width: 150, height: 150, alignment: .center)
                    }
                }
                .padding()
            }
            .navigationTitle("Endpoints")
        }
#elseif os(macOS)
        NavigationView {
            List(presenter.getNames(),id:\.self) { endpoint in
                        NavigationLink {
                            presenter.moveToEndpointList(endpoint: endpoint)
                        } label: {
                            buildCard(endpoint: endpoint)
                        }
                        .frame(width: 150, height: 150, alignment: .center)
                    }
                }
            .navigationTitle("Endpoints")
#endif
    }
    
    func buildCard(endpoint: Endpoint) -> EndpointCard {
        let interactor = EndpointCardInteractor(endpoint: endpoint)
        let endpointPresenter = EndpointCardPresenter(interactor: interactor)
        return EndpointCard(presenter: endpointPresenter)
    }
    
}
