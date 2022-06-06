//
//  EndpointListView.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

struct EndpointListView: View {
    
    @ObservedObject var presenter: EndpointListViewPresenter
    
    var body: some View {
        presenter.fetchSummary()
        return Text("")
    }
    
}
