//
//  EndpointListViewRouter.swift
//  Viper
//
//  Created by Gilberto vieira on 07/06/22.
//

import Foundation
import SwiftUI

class EndpointListViewRouter {
    func makeDetailView(endpoint: Endpoint, for summary: GenericEntity) -> DetailView {
        let interactor = DetailViewInteractor()
        let detailViewPresenter = DetailViewPresenter(interactor: interactor)
        detailViewPresenter.fetchEntity(endpoint: endpoint, summary: summary)
        return DetailView(presenter: detailViewPresenter)
    }
}
