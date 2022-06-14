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
        let _: [NSManagedObject] = entities.compactMap({ entity in
            if existsInCoreData(entity: entity as! GenericEntity) {
                return nil
            }
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
        entitiesFetchRequest.predicate = predicate
        do {
            let entities = try PersistenceController.shared.container.viewContext.fetch(entitiesFetchRequest)
            return convertToGenericEntities(entities: entities as! [Generic])
        } catch {
            return []
        }
    }
    
    func existsInCoreData(entity: GenericEntity) -> Bool {
        let entitiesFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GenericEntity.entityName)
        let predicate = NSPredicate(format: "endpoint == %@ AND id == %d", entity.endpoint.rawValue, entity.id!)
        entitiesFetchRequest.predicate = predicate
        do {
            let entities = try PersistenceController.shared.container.viewContext.fetch(entitiesFetchRequest)
            return entities.first != nil
        } catch {
            print("It was not possible to fetch")
            return false
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
