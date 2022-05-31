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
            IGDBWorker.worker.loadEndpointInfo(endpoint: presenter.endpointName, completionHandler: { result in
                print(result)
                // Create a fetch request with a string filter
                // for an entity’s name
                let context = PersistenceController.shared.container.viewContext
                let entity = NSEntityDescription.entity(forEntityName: GameEntity.EntityName, in: context)
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: (entity?.name)!)

                fetchRequest.predicate = NSPredicate(
                    format: "name LIKE %@", "Robert"
                )

                // Get a reference to a NSManagedObjectContext

                // Perform the fetch request to get the objects
                // matching the predicate
                let objects = try? context.fetch(fetchRequest)
                print(objects)
                try? (result as! StructDecoder).toCoreData(context: context)
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
