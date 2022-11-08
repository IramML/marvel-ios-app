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
            id: Int(id ?? "0") ?? 0,
            digitalId: 0,
            title: title ?? "",
            issueNumber: 0,
            variantDescription: "",
            description: desc ?? "",
            modified: "",
            isbn: "",
            diamondCode: "",
            format: format ?? "",
            pageCount: Int(pageCount ?? "0") ?? 0,
            textObjects: [],
            series: ComicResource(resourceURI: "", name: ""),
            variants: [],
            collections: [],
            collectedIssues: [],
            dates: [],
            prices: [],
            thumbnail: ComicImage(path: imagePath ?? "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available", extensionImg: imageExtension ?? "jpg"),
            images: [],
            creators: ComicCreators(available: 0, returned: 0, collectionURI: "", items: []))
    }
}
