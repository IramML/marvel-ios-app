//
//  LocalError.swift
//  Data
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation

public enum LocalError {
    case databaseError
    case castingError
    case badRequest
    case generic(error: Error)
}
