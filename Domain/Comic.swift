//
//  Comic.swift
//  Domain
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation

public struct Comic {
    public init(id: Int, digitalId: Int, title: String, issueNumber: Double, variantDescription: String, description: String, modified: String, isbn: String, diamondCode: String, format: String, pageCount: String, textObjects: ComicTextObject, series: ComicResource, variants: [ComicResource], collections: [ComicResource], collectedIssues: [ComicResource], dates: [ComicDate], prices: [ComicPrice], thumbnail: ComicImage, images: [ComicImage], creators: ComicCreators) {
        self.id = id
        self.digitalId = digitalId
        self.title = title
        self.issueNumber = issueNumber
        self.variantDescription = variantDescription
        self.description = description
        self.modified = modified
        self.isbn = isbn
        self.diamondCode = diamondCode
        self.format = format
        self.pageCount = pageCount
        self.textObjects = textObjects
        self.series = series
        self.variants = variants
        self.collections = collections
        self.collectedIssues = collectedIssues
        self.dates = dates
        self.prices = prices
        self.thumbnail = thumbnail
        self.images = images
        self.creators = creators
    }
    
    public var id: Int
    public var digitalId: Int
    public var title: String
    public var issueNumber: Double
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

