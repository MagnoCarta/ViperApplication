//
//  EndpointCard.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI


struct EndpointCard: View {
    
    @ObservedObject var presenter: EndpointCardPresenter
    let isTextCentered: Bool
    
    var body: some View {
        presenter.view = self
        return setUpView()
    }
    
    func setUpView() -> some View {
        Rectangle()
            .cornerRadius(15)
            .foregroundColor(.darkPink)
        
            .shadow(color: Color.gray, radius: 3, x: 0, y: 0)
            .overlay(alignment: .center, content: {
                if isTextCentered {
                    Text(presenter.getName())
                        .foregroundColor(.white)
                } else {
                    VStack {
                        AsyncImage(url: URL(string: "https:\(presenter.getImageURL())"))
                        Text(presenter.getName())
                            .foregroundColor(.white)
                    }
                }
            })
    }
    
    
}
