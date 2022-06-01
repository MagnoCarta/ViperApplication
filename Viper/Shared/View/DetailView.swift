//
//  DetailView.swift
//  Viper
//
//  Created by Gilberto vieira on 27/05/22.
//

import Foundation
import SwiftUI
import CoreData

struct DetailView: View {
    
    @ObservedObject var presenter: DetailViewPresenter
    @State var Botaomaluco: String
    
    var body: some View {
        return Button(Botaomaluco, action: {
            IGDBWorker.worker.loadEndpointInfo(endpointType: Endpoint(rawValue: presenter.endpointName)!.getArrayType(), completionHandler: { result in
                // Create a fetch request with a string filter
                // for an entity’s name
                let context = PersistenceController.shared.container.viewContext
                
                let fetchRequest = Character.fetchRequest()

//                fetchRequest.predicate = NSPredicate(
//                    format: "name LIKE %@", "Robert"
//                )

                // Get a reference to a NSManagedObjectContext

                // Perform the fetch request to get the objects
                // matching the predicate
                let objects = try? context.fetch(fetchRequest)
                print(objects)
                let managedObjects = (result as! [StructDecoder]).forEach({ try? $0.toCoreData(context: context) })
                try? context.save()
//                let dictionary = json as! [[String : Any]]
//
//                //let decoder = StructDecoder()
//
//
//                Botaomaluco = dictionary.first!.description
            })
        })
    }
    
}
