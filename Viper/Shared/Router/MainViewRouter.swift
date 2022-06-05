//
//  Router.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation

import SwiftUI

class MainViewRouter {
  func makeDetailView(for endpointName: Endpoint) -> DetailView {
      let interactor = DetailViewInteractor(endpoint: endpointName)
      let detailViewPresenter = DetailViewPresenter(interactor: interactor)
      return DetailView(presenter: detailViewPresenter)
  }
}

