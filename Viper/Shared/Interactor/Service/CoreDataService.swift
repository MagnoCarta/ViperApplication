//
//  CoreDataService.swift
//  Viper
//
//  Created by Gilberto vieira on 05/06/22.
//

import Foundation
import CoreData

class CoreDataService {
    
    let context = PersistenceController.shared.container.viewContext
    static let service = CoreDataService()
    
    private init() {}
    
    func saveEntities(entities: [StructDecoder]) {
        _ = entities.compactMap({ entity in
            return try? entity.toCoreData(context: context)
        })
        do {
            try context.save()
        } catch {
            print("It was not possible to save the context")
            print(error)
        }
    }
    
    func getEntities(endpoint: Endpoint) -> [GenericEntity] {
        let entitiesFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GenericEntity.entityName)
        do {
            let entities = try PersistenceController.shared.container.viewContext.fetch(entitiesFetchRequest)
            return entities as! [GenericEntity]
        } catch {
            return []
        }
    }
    
}
