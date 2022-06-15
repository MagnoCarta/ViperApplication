//
//  GenericExtension.swift
//  Viper
//
//  Created by Rodrigo Matos Aguiar on 14/06/22.
//

import CoreData

extension Generic {
    
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.creationDate = Date.now
    }
}
