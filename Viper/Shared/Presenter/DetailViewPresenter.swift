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
        return interactor?.endpointEntity?.name ?? "Default Name"
    }
    
    func getImageURL() -> String {
        guard let imageURL = interactor?.endpointEntity?.imageURL else {
            return ""
        }
        let bigCover = imageURL.replacingOccurrences(of: "thumb", with: "cover_big")
        return bigCover
    }
    
    func getDescription() -> String {
        return interactor?.endpointEntity?.textDescription ?? "No Description"
    }
    
    func hasLoadedEntity() -> Bool {
        return interactor?.endpointEntity != nil
    }
    
    // MARK: Fetch Functions
    func fetchEntity(endpoint: Endpoint, summary: GenericEntity) {
        interactor?.setEndpoint(endpoint: endpoint, summary: summary)
    }
    
    func hasFetchedEntity() {
        DispatchQueue.main.async {
            self.updateToggle = !self.updateToggle
        }
    }
}
