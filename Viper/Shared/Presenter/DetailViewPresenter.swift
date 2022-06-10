//
//  DetailViewPresenter.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 05/06/22.
//

import Foundation
import SwiftUI

class DetailViewPresenter: ObservableObject {
    
    // MARK: Variables
    private var interactor: DetailViewInteractor?
    var view: DetailView?
    @Published var updateToggle: Bool = false
    
    init(interactor: DetailViewInteractor) {
        self.interactor = interactor
        interactor.presenter = self
    }
    
    // MARK: Get Functions
    func getName() -> String {
        return interactor?.name ?? "Default Name"
    }
    
    func getImageURL() -> String {
        return interactor?.endpointEntity?.imageURL ?? ""
    }
    
    func getEntity() -> GenericEntity? {
        return interactor?.endpointEntity
    }
    
    // MARK: Fetch Functions
    func fetchNameAndImage(endpoint: Endpoint,name: String) {
        interactor?.fetchEndpointAndName(endpoint: endpoint, name: name)
    }
    
    func fetchEntity() {
        interactor?.fetchEntity()
    }
    
    func hasFetchedEntity() {
        DispatchQueue.main.async {
            self.updateToggle = !self.updateToggle
        }
    }
}
