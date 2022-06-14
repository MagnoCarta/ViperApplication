//
//  DetailView.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 05/06/22.
//

import Foundation
import SwiftUI


struct DetailView: View {
    
    @ObservedObject var presenter: DetailViewPresenter
    
    var body: some View {
        presenter.view = self
        return ScrollView {
            AsyncImage(url: URL(string: "https:\(presenter.getImageURL())"))
                .padding(.vertical, 16)
            if presenter.hasLoadedEntity() {
                Text(presenter.getDescription())
            } else {
                ProgressView()
                    .scaleEffect(x: 3, y: 3, anchor: .top)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(presenter.getName())
        .padding(.horizontal, 24)
    }
    
}
