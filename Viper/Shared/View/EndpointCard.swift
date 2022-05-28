//
//  EndpointCard.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI


struct EndpointCard: View {
    
    @State var name: String
    
    var body: some View {
        Rectangle()
            .cornerRadius(15)
            .foregroundColor(.green)
            .overlay(alignment: .center, content: {
                Text(name)
            })
    }
    
}
