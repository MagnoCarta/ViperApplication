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
      endpointListViewPresenter.fetchEndpoint(endpoint: endpointName)
      return EndpointListView(presenter: endpointListViewPresenter)
  }
}

