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
    @State var summaries: [SummaryEntity] = []
    
    var body: some View {
        presenter.view = self
        presenter.fetchSummary()
            return ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(summaries,id:\.self) { summary in
                        NavigationLink {
                            if let summaryName = summary.name {
                                presenter.moveToDetailView(name: summaryName)
                            }
                        } label: {
                            buildCard(endpoint: presenter.endpointName, name: summary.name ?? "No Name", imageURL: summary.imageURL ?? "No url")
                        }
                        .frame(width: 150, height: 150, alignment: .center)
                    }
                }
                .padding()
                .navigationTitle(presenter.endpointName.rawValue)
            }
    }
    
    func buildCard(endpoint: Endpoint,name: String,imageURL: String) -> EndpointCard {
        let interactor = EndpointCardInteractor(endpoint: endpoint,name: name,imageURL: imageURL)
        let endpointPresenter = EndpointCardPresenter(interactor: interactor)
        return EndpointCard(presenter: endpointPresenter, isTextCentered: false)
    }
    
}
