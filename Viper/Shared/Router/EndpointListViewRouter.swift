//
//  EndpointListViewRouter.swift
//  Viper
//
//  Created by Gilberto vieira on 07/06/22.
//

import Foundation
import SwiftUI

class EndpointListViewRouter {
    func makeDetailView(endpoint: Endpoint, for name: String) -> DetailView {
        let interactor = DetailViewInteractor(endpoint: endpoint, name: name)
        let detailViewPresenter = DetailViewPresenter(interactor: interactor)
        return DetailView(presenter: detailViewPresenter)
    }
}
