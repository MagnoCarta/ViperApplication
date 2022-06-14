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
      let interactor = EndpointListViewInteractor()
      let endpointListViewPresenter = EndpointListViewPresenter(interactor: interactor)
      let endpointListView = EndpointListView(presenter: endpointListViewPresenter)
      endpointListViewPresenter.fetchEndpoint(endpoint: endpointName)
      return endpointListView
  }
}

