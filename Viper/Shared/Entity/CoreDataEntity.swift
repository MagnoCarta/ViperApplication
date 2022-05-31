//
//  Entity.swift
//  Viper
//
//  Created by Gilberto vieira on 26/05/22.
//

import Foundation
import CoreData


protocol StructDecoder {

     // The name of our Core Data Entity

     static var EntityName: String { get }

     // Return an NSManagedObject with our properties set

     func toCoreData(context: NSManagedObjectContext) throws -> NSManagedObject
    
    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> 

}

enum SerializationError: Error {

     // We only support structs

     case structRequired

     // The entity does not exist in the Core Data Model

     case unknownEntity(name: String)

     // The provided type cannot be stored in core data

     case unsupportedSubType(label: String?)

}


extension StructDecoder {

     func toCoreData(context: NSManagedObjectContext) throws -> NSManagedObject {

         let entityName = type(of:self).EntityName



         // Create the Entity Description

         guard let desc = NSEntityDescription.entity(forEntityName: entityName, in: context)

         else { throw SerializationError.unknownEntity(name: entityName) }



         // Create the NSManagedObject

         let managedObject = NSManagedObject(entity: desc, insertInto: context)



         // Create a Mirror

         let mirror = Mirror(reflecting: self)



         // Make sure we're analyzing a struct

         guard mirror.displayStyle == .struct else { throw SerializationError.structRequired }

         for case let (label?, anyValue) in mirror.children {

             managedObject.setValue(anyValue, forKey: label)

         }

         return managedObject

     }

}
