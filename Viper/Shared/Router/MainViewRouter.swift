//
//  Router.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation

import SwiftUI

class MainViewRouter {
  func makeEndpointListView(for endpointName: Endpoint) -> EndpointListView {
      let interactor = EndpointListViewInteractor(endpoint: endpointName)
      let endpointListViewPresenter = EndpointListViewPresenter(interactor: interactor)
      return EndpointListView(presenter: endpointListViewPresenter)
  }
}

