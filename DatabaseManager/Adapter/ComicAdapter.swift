//
//  ComicAdapter.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Domain

extension Array where Element == LocalComic {
    func toDomain() -> [Comic] {
        map {
            $0.toDomain()
        }
    }
}

extension LocalComic {
    func toDomain() -> Comic {
        Comic(
            id: Int(id),
            digitalId: 0,
            title: title ?? "",
            issueNumber: 0,
            variantDescription: "",
            description: desc ?? "",
            modified: "",
            isbn: "",
            diamondCode: "",
            format: format ?? "",
            pageCount: Int(pageCount),
            textObjects: [],
            series: ComicResource(resourceURI: "", name: ""),
            variants: [],
            collections: [],
            collectedIssues: [],
            dates: [],
            prices: [],
            thumbnail: thumbnail?.toDomain() ?? ComicImage(path: "https://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extensionImg: "jpg"),
            images: [],
            creators: ComicCreators(available: 0, returned: 0, collectionURI: "", items: []))
    }
}

extension LocalComicImage {
    func toDomain() -> ComicImage {
        ComicImage(path: path ?? "", extensionImg: extensionImg ?? "")
    }
}
