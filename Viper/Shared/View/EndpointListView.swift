//
//  EndpointListView.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

struct EndpointListView: View {
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let height: CGFloat = 150
    @ObservedObject var presenter: EndpointListViewPresenter
    
    init(presenter: EndpointListViewPresenter) {
        self.presenter = presenter
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        presenter.view = self
        presenter.changePageIfNeeded(summary: nil)
        return ScrollView {
            if presenter.hasLoadedSummaries() {
                grid
            } else {
                ProgressView()
                    .scaleEffect(CGSize(width: 3, height: 3))
                // TODO: remove gambiarra
                Rectangle()
                    .foregroundColor(.clear)
                    .scaledToFill()
            }
        }
        .background(Color.darkPurple)
    }
    
    var grid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(presenter.getSummaries(),id:\.self) { summary in
                NavigationLink {
                    NavigationLazyView(presenter.moveToDetailView(entity: summary))
                } label: {
                    buildCard(endpoint: presenter.getEndpoint(), name: summary.name ?? "No Name", imageURL: summary.imageURL ?? "No url")
                        .onAppear(){
                            presenter.changePageIfNeeded(summary: summary)
                        }
                }
                .frame(width: 150, height: 150, alignment: .center)
            }
        }
        .padding()
        .navigationTitle(presenter.getEndpoint().rawValue)
    }
    
    func buildCard(endpoint: Endpoint,name: String,imageURL: String) -> EndpointCard {
        let interactor = EndpointCardInteractor()
        let endpointPresenter = EndpointCardPresenter(interactor: interactor)
        let endpointCard = EndpointCard(presenter: endpointPresenter, isTextCentered: false)
        endpointPresenter.fetchCard(endpoint: endpoint, name: name, imageURL: imageURL)
        return endpointCard
    }
    
}
