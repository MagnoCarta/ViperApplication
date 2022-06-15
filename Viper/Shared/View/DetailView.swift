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
            AsyncImage(url: URL(string: "https:\(presenter.getImageURL())")) { image in
                image
                    .resizable()
                    .padding(.vertical, 16)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5, alignment: .top)
            } placeholder: {
                ProgressView()
            }
            Text(presenter.getName())
                .font(.system(size: 24))
                .fontWeight(.bold)
            ScrollView {
                if presenter.hasLoadedEntity() {
                    Text(presenter.getDescription())
                        .padding(.horizontal, 24)
                } else {
                    ProgressView()
                        .scaleEffect(x: 3, y: 3, anchor: .top)
                }
            }
        }
        .background(Color.darkPurple)
    }
    
}
