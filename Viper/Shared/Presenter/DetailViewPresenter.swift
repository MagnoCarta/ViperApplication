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
    
    
    func getInformation() -> StructDecoder {
        
        return CompanyEntity(id: nil, changeDateCategory: nil, country: nil, createdAt: nil, companyDescription: nil, developed: nil, logo: nil, name: nil, slug: nil, startDate: nil, startDateCategory: nil, updatedAt: nil, url: nil, websites: nil, checksum: nil, published: nil, parent: nil, changeDate: nil, changedCompanyID: nil, logoURL: nil)
    }
    
    func fetchedNamesAndImages() {
        
    }
    
}
