//
//  BaseDataBase.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation

public class BaseDataBase {
    let databaseClient: DatabaseClient
    
    public init(databaseClient: DatabaseClient = CoredataClient()) {
        self.databaseClient = databaseClient
    }
}
