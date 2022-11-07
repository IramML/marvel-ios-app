//
//  RemoteError.swift
//  Data
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation

public enum RemoteError {
    case httpError
    case castingError
    case badRequest
    case generic(error: Error)
}
