//
//  DatabaseClient.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Data

public protocol DatabaseClient {
    func get<T>(databaseEntity: DatabaseEntity, completion: @escaping (LocalResult<[T]>) -> Void)
    func get<T>(byId id: String, databaseEntity: DatabaseEntity, completion: @escaping (LocalResult<T?>) -> Void)
    func add(databaseEntity: DatabaseEntity, data: [String: Any], completion: @escaping (LocalResult<Bool>) -> Void)
    func remove(byId id: String, databaseEntity: DatabaseEntity, completion: @escaping (LocalResult<Bool>) -> Void)
}
