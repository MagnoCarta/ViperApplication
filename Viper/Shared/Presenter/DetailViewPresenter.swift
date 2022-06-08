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

    //private let router = EndpointRouter()
    
    init(interactor: DetailViewInteractor) {
        self.interactor = interactor
        interactor.presenter = self
    }
    
    func getName() -> String {
        interactor.name ?? "No Name"
    }
    
    func getImageURL() -> String {
        var imageURL = ""
        guard let _ = interactor.endpointEntity else {
            return imageURL
        }
        switch interactor.endpoint {
        case .character:
            let character = interactor.endpointEntity as! CharacterEntity
            if let characterMugShotURL = character.mugShotURL {
                imageURL = characterMugShotURL
            }
        case .company:
            let company = interactor.endpointEntity as! CompanyEntity
            if let companyLogoURL = company.logoURL {
                imageURL = companyLogoURL
            }
        case .game:
            let game = interactor.endpointEntity as! GameEntity
            if let gameCoverURL = game.coverURL {
                imageURL = gameCoverURL
            }
        case .platform:
            let platform = interactor.endpointEntity as! PlatformEntity
            if let platformLogoURL = platform.platformLogoURL {
                imageURL = platformLogoURL
            }
        }
        return imageURL
    }
    
    func fetchEntity() {
        interactor.fetchEntity()
    }
    
    func hasFetchedEntity() {
        view?.entity = interactor.endpointEntity
    }
    
}
