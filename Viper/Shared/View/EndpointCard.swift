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
    
    var body: some View {
        presenter.view = self
        return setUpView()
    }
    
    func setUpView() -> some View {
        Rectangle()
            .cornerRadius(15)
            .foregroundColor(.blue)
            .overlay(alignment: .center, content: {
                ZStack {
                    AsyncImage(url: URL(string: presenter.getImageURL()))
                    Text(presenter.getNames())
                    .foregroundColor(.black)
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
