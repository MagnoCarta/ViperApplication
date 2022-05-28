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
    
    var body: some View {
                
        Rectangle()
            .cornerRadius(15)
            .foregroundColor(.black)
            .overlay(alignment: .center, content: {
                Text(presenter.endpointName)
            })
    }
    
    
}
