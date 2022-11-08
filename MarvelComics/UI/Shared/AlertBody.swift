//
//  AlertBody.swift
//  MarvelComics
//
//  Created by Iram Martinez on 08/11/22.
//

import Foundation

class AlertBody: ObservableObject {
    @Published var shouldShow: Bool
    @Published var title: String
    
    init(shouldShow: Bool = false, title: String = "") {
        self.shouldShow = shouldShow
        self.title = title
    }
}
