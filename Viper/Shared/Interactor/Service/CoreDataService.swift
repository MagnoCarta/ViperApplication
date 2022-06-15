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
        let predicate = NSPredicate(format: "endpoint == %@", endpoint.rawValue)
        let descriptor = NSSortDescriptor(key: "creationDate", ascending: true)
        entitiesFetchRequest.predicate = predicate
        entitiesFetchRequest.sortDescriptors = [descriptor]
        do {
            let entities = try PersistenceController.shared.container.viewContext.fetch(entitiesFetchRequest)
            return convertToGenericEntities(entities: entities as! [Generic])
        } catch {
            return []
        }
    }
    
    func convertToGenericEntities(entities: [Generic]) -> [GenericEntity] {
        var converteEntities: [GenericEntity] = []
        converteEntities = entities.map( { entity in
            GenericEntity(endpoint: Endpoint(rawValue: entity.endpoint ?? "Character")!, id: Int(entity.id), name: entity.name ?? "No Name", textDescription: entity.textDescription ?? "No Description", imageID: Int(entity.imageID), imageURL: entity.imageURL ?? "No Url")
        })
        return converteEntities
    }
    
}
