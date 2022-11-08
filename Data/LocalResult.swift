//
//  LocalResult.swift
//  Data
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation

public enum LocalResult<T> {
    case success(data: T)
    case failure(error: LocalError)
}
