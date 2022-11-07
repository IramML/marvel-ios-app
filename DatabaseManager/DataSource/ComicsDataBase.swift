//
//  ComicsDataBase.swift
//  DatabaseManager
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Data
import Domain

final class ComicsDataBase: BaseDataBase, ComicsLocalDataSource {
    
    func getFavoriteComics(completion: @escaping (LocalResult<[Comic]>) -> Void) {
        self.databaseClient.get(databaseEntity: .comics) { (result: LocalResult<[LocalComic]>) in
            switch result {
            case .success(let data):
                completion(.success(data: data.toDomain()))
            case .failure(let error):
                completion(.failure(error: error))
            }
        }
    }
    
    func getFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Comic?>) -> Void) {
        self.databaseClient.get(byId: "\(comicId)", databaseEntity: .comics) { (result: LocalResult<LocalComic?>) in
            switch result {
            case .success(let data):
               completion(.success(data: data?.toDomain()))
            case .failure(let error):
               completion(.failure(error: error))
            }
        }
    }
    
    func addFavoriteComic(_ comic: Comic, completion: @escaping (LocalResult<Bool>) -> Void) {
        let dict: [String: Any] = [
            "id": comic.id,
            "title": comic.title,
            "desc": comic.description,
            "format": comic.format,
            "pageCount": comic.pageCount,
            "thumbnail": [
                "path": comic.thumbnail.path,
                "extensionImg": comic.thumbnail.extensionImg
            ],
        ]
        self.databaseClient.add(databaseEntity: .comics, data: dict, completion: completion)
    }
    
    func removeFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Bool>) -> Void) {
        self.databaseClient.remove(byId: "\(comicId)", databaseEntity: DatabaseEntity.comics, completion: completion)
    }
    
    
}
