//
//  Comic+Hashable.swift
//  MarvelComics
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Domain

extension Comic: Hashable {
    public static func == (lhs: Comic, rhs: Comic) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
