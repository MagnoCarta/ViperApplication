//
//  SummaryEntity.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 05/06/22.
//

import Foundation

struct SummaryEntity: Codable, StructDecoder, Hashable {
    static var entityName: String = "Summary"
    
    let originalEntity: String?
    let name: String?
    var imageURL: String?
}
