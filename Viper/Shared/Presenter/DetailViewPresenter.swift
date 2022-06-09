//
//  DetailViewPresenter.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 05/06/22.
//

import Foundation
import SwiftUI

class DetailViewPresenter: ObservableObject {
    
    private let interactor: DetailViewInteractor
    var view: DetailView?
    @Published var updateToggle: Bool = false
    
    init(interactor: DetailViewInteractor) {
        self.interactor = interactor
        interactor.presenter = self
        self.fetchEntity()
    }
    
    func getName() -> String {
        return interactor.name
    }
    
    func getImageURL() -> String {
        return interactor.endpointEntity?.imageURL ?? ""
    }
    
    func fetchEntity() {
        return interactor.fetchEntity()
    }
    
    func hasFetchedEntity() {
        DispatchQueue.main.async {
            self.updateToggle = !self.updateToggle
        }
    }
    
    func getEntity() -> GenericEntity? {
        return interactor.endpointEntity
    }
    
}
