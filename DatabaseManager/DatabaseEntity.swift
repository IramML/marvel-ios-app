//
//  DatabaseEntity.swift
//  Data
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import CoreData

public enum DatabaseEntity {
    case comics
    
    public var entityName: String {
        switch self {
        case .comics:
            return "LocalComic"
        }
    }
}
