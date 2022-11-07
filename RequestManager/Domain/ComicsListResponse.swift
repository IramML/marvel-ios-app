//
//  ComicsListResponse.swift
//  RequestManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation

struct ComicsListResponse: Codable {
    var data: ComicsListResponseData
}

struct ComicsListResponseData: Codable {
    var results: [RemoteComic]
}

struct RemoteComic: Codable {
    var id: Int
    var digitalId: Int
    var title: String
    var issueNumber: Double
    var variantDescription: String
    var description: String
    var modified: String
    var isbn: String
    var diamondCode: String
    var format: String
    var pageCount: String
    var textObjects: RemoteComicTextObject
    var series: RemoteComicResource
    var variants: [RemoteComicResource]
    var collections: [RemoteComicResource]
    var collectedIssues: [RemoteComicResource]
    var dates: [RemoteComicDate]
    var prices: [RemoteComicPrice]
    var thumbnail: RemoteComicImage
    var images: [RemoteComicImage]
    var creators: RemoteComicCreators
}

struct RemoteComicTextObject: Codable {
    var type: String
    var language: String
    var text: String
}

struct RemoteComicDate: Codable {
    var type: String
    var date: String
}

struct RemoteComicPrice: Codable {
    var type: String
    var price: String
}

struct RemoteComicResource: Codable {
    var resourceURI: String
    public var name: String
}

struct RemoteComicImage: Codable {
    var path: String
    var extensionImg: String
    
    private enum CodingKeys : String, CodingKey {
        case path, extensionImg = "extension"
    }
}

struct RemoteComicCreators: Codable {
    var available: Int
    var returned: Int
    var collectionURI: String
    var items: [RemoteComicCreatorsItem]
}
struct RemoteComicCreatorsItem: Codable {
    var resourceURI: String
    var name: String
    var role: String
}
