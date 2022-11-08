//
//  ComicsLocalDataSource.swift
//  Data
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Domain

public protocol ComicsLocalDataSource {
    func getFavoriteComics(completion: @escaping (LocalResult<[Comic]>) -> Void)
    func getFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Comic?>) -> Void)
    func addFavoriteComic(_ comic: Comic, completion: @escaping (LocalResult<Bool>) -> Void)
    func removeFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Bool>) -> Void)
}
