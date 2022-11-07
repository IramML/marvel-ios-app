//
//  BaseDataBase.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation

class BaseDataBase {
    let databaseClient: DatabaseClient
    
    init(databaseClient: DatabaseClient = CoredataClient()) {
        self.databaseClient = databaseClient
    }
}
