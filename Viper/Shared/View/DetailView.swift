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
        return VStack {
            AsyncImage(url: URL(string: "https:\(presenter.getImageURL())"))
        }
        .navigationTitle(presenter.getName())
    }
    
}
