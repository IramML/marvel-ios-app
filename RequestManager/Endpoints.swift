//
//  Endpoints.swift
//  RequestManager
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation

enum Endpoints {
    case comics
    
    public var path: String {
        switch self {
        case .comics:
            return "/comics"
        }
    }
}
