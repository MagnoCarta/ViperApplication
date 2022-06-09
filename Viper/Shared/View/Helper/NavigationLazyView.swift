//
//  NavigationLazyView.swift
//  Viper (iOS)
//
//  Created by Rodrigo Matos Aguiar on 08/06/22.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
