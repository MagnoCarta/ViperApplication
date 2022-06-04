//
//  Router.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation

import SwiftUI

class MainViewRouter {
  func makeDetailView(for endpointName: Endpoint) -> some View {
    let presenter = DetailViewPresenter(interactor: DetailViewInteractor(endpoint: endpointName))
      return DetailView(presenter: presenter,Botaomaluco: presenter.endpointName)
  }
}

