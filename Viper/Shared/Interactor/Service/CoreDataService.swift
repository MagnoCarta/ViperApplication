//
//  CoreDataService.swift
//  Viper
//
//  Created by Gilberto vieira on 05/06/22.
//

import Foundation
import CoreData

class CoreDataService {
    
    
    func saveSummary() {
        
    }
    
    func getSummary() {
        let summaryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: GenericEntity.entityName)
        do {
            let summaries = try PersistenceController.shared.container.viewContext.fetch(summaryFetchRequest)
            print(summaries)
        } catch {
            
        }
    }
    
    func getEntity() {
        
    }
    
}
