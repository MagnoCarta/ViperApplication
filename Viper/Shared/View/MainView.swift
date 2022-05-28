//
//  View.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI


struct MainView: View {
    
    @State var endpoints: [String]
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    let height: CGFloat = 150
    
    var body: some View {
        
        ScrollView {
            // 4. Populate into grid
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(endpoints,id:\.self) { endpoint in
                    EndpointCard(name: endpoint)
                        .frame(height: height)
                }
            }
            .padding()
        }
    }
}
