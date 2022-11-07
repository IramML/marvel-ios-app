//
//  Comic.swift
//  Domain
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation

public struct Comic {
    public var id: Int
    public var digitalId: Int
    public var title: String
    public var issueNumber: String
    public var variantDescription: String
    public var description: String
    public var modified: String
    public var isbn: String
    public var diamondCode: String
    public var format: String
    public var pageCount: String
    public var textObjects: ComicTextObject
    public var series: ComicResource
    public var variants: [ComicResource]
    public var collections: [ComicResource]
    public var collectedIssues: [ComicResource]
    public var dates: [ComicDate]
    public var prices: [ComicPrice]
    public var thumbnail: ComicImage
    public var images: [ComicImage]
    public var creators: ComicCreators
}

public struct ComicTextObject {
    public init(type: String, language: String, text: String) {
        self.type = type
        self.language = language
        self.text = text
    }
    
    public var type: String
    public var language: String
    public var text: String
}

public struct ComicDate {
    public init(type: String, date: String) {
        self.type = type
        self.date = date
    }
    
    public var type: String
    public var date: String
}

public struct ComicPrice {
    public init(type: String, price: String) {
        self.type = type
        self.price = price
    }
    
    public var type: String
    public var price: String
}

public struct ComicResource {
    public init(resourceURI: String, name: String) {
        self.resourceURI = resourceURI
        self.name = name
    }
    
    public var resourceURI: String
    public var name: String
}

public struct ComicImage {
    public init(path: String, extensionImg: String) {
        self.path = path
        self.extensionImg = extensionImg
    }
    
    public var path: String
    public var extensionImg: String
}

public struct ComicCreators {
    public init(available: Int, returned: Int, collectionURI: String, items: [ComicCreatorsItem]) {
        self.available = available
        self.returned = returned
        self.collectionURI = collectionURI
        self.items = items
    }
    
    public var available: Int
    public var returned: Int
    public var collectionURI: String
    public var items: [ComicCreatorsItem]
}
public struct ComicCreatorsItem {
    public init(resourceURI: String, name: String, role: String) {
        self.resourceURI = resourceURI
        self.name = name
        self.role = role
    }
    
    public var resourceURI: String
    public var name: String
    public var role: String
}

