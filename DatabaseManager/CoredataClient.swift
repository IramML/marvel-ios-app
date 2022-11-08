//
//  CoredataClient.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Data
import CoreData

public final class CoredataClient: DatabaseClient {
    
    private let viewContext = PersistenceController.shared.container.viewContext
    
    public init() {
        
    }
    
    public func get<T>(databaseEntity: DatabaseEntity, completion: @escaping (LocalResult<[T]>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: databaseEntity.entityName)
        
        if let results: [T] = try? viewContext.fetch(request) as? [T] {
            completion(.success(data: results))
        } else {
            completion(.failure(error: .databaseError))
        }
    }
    
    public func get<T>(byId id: String, databaseEntity: DatabaseEntity, completion: @escaping (LocalResult<T?>) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: databaseEntity.entityName)
        request.predicate = NSPredicate(format: "id == %@", id)
        
        if let results: [T] = try? viewContext.fetch(request) as? [T] {
            completion(.success(data: results.first))
        } else {
            completion(.failure(error: .databaseError))
        }
    }
    
    public func add(databaseEntity: DatabaseEntity, data: [String: Any], completion: @escaping (LocalResult<Bool>) -> Void) {
        let insertRequest = NSBatchInsertRequest(entityName: databaseEntity.entityName, objects: [data])
        insertRequest.resultType = NSBatchInsertRequestResultType.objectIDs
        let result = try? PersistenceController.shared.container.newBackgroundContext().execute(insertRequest) as? NSBatchInsertResult
        
        if let objectIDs = result?.result as? [NSManagedObjectID], !objectIDs.isEmpty {
            let save = [NSInsertedObjectsKey: objectIDs]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: save, into: [viewContext])
            completion(.success(data: true))
            return
        }
        completion(.success(data: false))
    }
    
    public func remove(byId id: String, databaseEntity: DatabaseEntity, completion: @escaping (LocalResult<Bool>) -> Void) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: databaseEntity.entityName)

        fetch.predicate = NSPredicate(format: "id == %@", id)

        let req = NSBatchDeleteRequest(fetchRequest: fetch)
        
        req.resultType = .resultTypeCount

            do {
                let result = try viewContext.execute(req) as? NSBatchDeleteResult
                
                if let result = result?.result as? Int, result > 0 {
                    completion(.success(data: true))
                } else {
                    completion(.success(data: false))
                }
            } catch {
                completion(.failure(error: .databaseError))
            }
    }
}
