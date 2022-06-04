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
    @State var Botaomaluco: Endpoint
    
    var body: some View {
        return Button(Botaomaluco.rawValue, action: {
            IGDBWorker.worker.loadEndpointInfo(endpoint: Botaomaluco, completionHandler: { result in
                // Create a fetch request with a string filter
                // for an entity’s name
                let context = PersistenceController.shared.container.viewContext
                
                var fetchRequest: NSFetchRequest<NSFetchRequestResult>?
                switch Botaomaluco {
                case .character:
                    fetchRequest = Character.fetchRequest()
                case .company:
                    fetchRequest = Company.fetchRequest()
                case .game:
                    fetchRequest = Game.fetchRequest()
                case .platform:
                    fetchRequest = Platform.fetchRequest()
                }

//                fetchRequest.predicate = NSPredicate(
//                    format: "name LIKE %@", "Robert"
//                )

                // Get a reference to a NSManagedObjectContext

                // Perform the fetch request to get the objects
                // matching the predicate
                let objects = try? context.fetch(fetchRequest!)
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
