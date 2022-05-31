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
                    ForEach(presenter.endpointNames,id:\.self) { endpoint in
                        NavigationLink {
                            let interactor = DetailViewInteractor(nome: endpoint)
                            let detailViewPresenter = DetailViewPresenter(interactor: interactor)
                            DetailView(presenter: detailViewPresenter,Botaomaluco: detailViewPresenter.endpointName)
                        } label: {
                            let interactor = EndpointCardInteractor(nome: endpoint)
                            let endpointPresenter = EndpointCardPresenter(interactor: interactor)
                            EndpointCard(presenter: endpointPresenter)
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
            List(presenter.endpointNames,id:\.self) { endpoint in
                        NavigationLink {
                            let interactor = DetailViewInteractor(nome: endpoint)
                            let detailViewPresenter = DetailViewPresenter(interactor: interactor)
                            DetailView(presenter: detailViewPresenter,Botaomaluco: detailViewPresenter.endpointName)
                        } label: {
                            let interactor = EndpointCardInteractor(nome: endpoint)
                            let endpointPresenter = EndpointCardPresenter(interactor: interactor)
                            EndpointCard(presenter: endpointPresenter)
                        }
                        .frame(width: 150, height: 150, alignment: .center)
                    }
                }
            .navigationTitle("Endpoints")
#endif
    }
}
