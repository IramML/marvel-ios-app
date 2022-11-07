//
//  ComicsAdapter.swift
//  RequestManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Domain

extension Array where Element == RemoteComic {
    func toDomain() -> [Comic] {
        self.map { Comic(
            id: $0.id,
            digitalId: $0.digitalId,
            title: $0.title,
            issueNumber: $0.issueNumber,
            variantDescription: $0.variantDescription,
            description: $0.description,
            modified: $0.modified,
            isbn: $0.isbn,
            diamondCode: $0.diamondCode,
            format: $0.format,
            pageCount: $0.pageCount,
            textObjects: $0.textObjects.toDomain(),
            series: $0.series.toDomain(),
            variants: $0.variants.toDomain(),
            collections: $0.collections.toDomain(),
            collectedIssues: $0.collectedIssues.toDomain(),
            dates: $0.dates.toDomain(),
            prices: $0.prices.toDomain(),
            thumbnail: $0.thumbnail.toDomain(),
            images: $0.images.toDomain(),
            creators: $0.creators.toDomain())  }
        
    }
}

extension Array where Element == RemoteComicResource {
    func toDomain() -> [ComicResource] {
        map { ComicResource(resourceURI: $0.resourceURI, name: $0.name) }
    }
}

extension Array where Element == RemoteComicTextObject {
    func toDomain() -> [ComicTextObject] {
        map { ComicTextObject(type: $0.type, language: $0.language, text: $0.text)}
    }
}

extension RemoteComicResource {
    func toDomain() -> ComicResource {
        ComicResource(resourceURI: resourceURI, name: name)
    }
}

extension RemoteComicImage {
    func toDomain() -> ComicImage {
        ComicImage(path: path, extensionImg: extensionImg)
    }
}

extension RemoteComicCreators {
    func toDomain() -> ComicCreators {
        ComicCreators(available: available, returned: returned, collectionURI: collectionURI, items: items.toDomain())
    }
}

extension Array where Element == RemoteComicCreatorsItem {
    func toDomain() -> [ComicCreatorsItem] {
        map { ComicCreatorsItem(resourceURI: $0.resourceURI, name: $0.name, role: $0.role) }
    }
}

extension Array where Element == RemoteComicImage {
    func toDomain() -> [ComicImage] {
        map { ComicImage(path: $0.path, extensionImg: $0.extensionImg) }
    }
}

extension Array where Element == RemoteComicDate {
    func toDomain() -> [ComicDate] {
        map { ComicDate(type: $0.type, date: $0.date) }
    }
}

extension Array where Element == RemoteComicPrice {
    func toDomain() -> [ComicPrice] {
        map { ComicPrice(type: $0.type, price: $0.price) }
    }
}

