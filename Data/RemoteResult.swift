//
//  RemoteResult.swift
//  Data
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation

public enum RemoteResult<T> {
    case success(data: T)
    case failure(error: RemoteError)
}


