//
//  EndpointCard.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI


struct EndpointCard: View {
    
    let presenter: EndpointCardPresenter
    @State var observedObject: String?
    let isTextCentered: Bool
    
    var body: some View {
        presenter.view = self
        return setUpView()
    }
    
    func setUpView() -> some View {
        Rectangle()
            .cornerRadius(15)
            .foregroundColor(.blue)
            .overlay(alignment: .center, content: {
                if isTextCentered {
                    Text(presenter.getNames())
                        .foregroundColor(.black)
                } else {
                    VStack {
                        AsyncImage(url: URL(string: "https:\(presenter.getImageURL())"))
                        Text(presenter.getNames())
                            .foregroundColor(.black)
                    }
                }
            })
    }
    
    func resetView() {
        if let _ = observedObject {
            self.observedObject! += "."
        } else {
            observedObject = "."
        }
    }
    
}
