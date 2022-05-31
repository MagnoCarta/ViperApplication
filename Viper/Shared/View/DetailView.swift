//
//  DetailView.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI

struct DetailView: View {
    
    @ObservedObject var presenter: DetailViewPresenter
    @State var Botaomaluco: String
    
    var body: some View {
        return Button(Botaomaluco, action: {
            IGDBWorker.worker.loadEndpointInfo(endpoint: presenter.endpointName, completionHandler: { result in
                let json = result
                let dictionary = json as! [[String : Any]]
                
                Botaomaluco = dictionary.first!.description
            })
        })
    }
    
}
