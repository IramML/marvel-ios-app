//
//  ComicsLocalDataSourceSpy.swift
//  DataTests
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
@testable import Data
import Domain

final class ComicsLocalDataSourceSpy: ComicsLocalDataSource {
    private(set) var comicsCompletions: [ComicsCompletion] = []
    private var getFavoriteComicsCompletions: [(LocalResult<[Comic]>) -> Void] = []
    private var getFavoriteComicCompletions: [(LocalResult<Comic?>) -> Void] = []
    private var addFavoriteComicCompletions: [(LocalResult<Bool>) -> Void] = []
    private var removeFavoriteComicCompletions: [(LocalResult<Bool>) -> Void] = []
    
    enum ComicsCompletion {
        case getComics
        case getComic
        case addComic
        case removeComic
    }
    
    func getFavoriteComics(completion: @escaping (LocalResult<[Comic]>) -> Void) {
        comicsCompletions.append(.getComics)
        getFavoriteComicsCompletions.append(completion)
    }
    
    func getFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Comic?>) -> Void) {
        comicsCompletions.append(.getComic)
        getFavoriteComicCompletions.append(completion)
    }
    
    func addFavoriteComic(_ comic: Domain.Comic, completion: @escaping (LocalResult<Bool>) -> Void) {
        comicsCompletions.append(.addComic)
        addFavoriteComicCompletions.append(completion)
    }
    
    func removeFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Bool>) -> Void) {
        comicsCompletions.append(.removeComic)
        removeFavoriteComicCompletions.append(completion)
    }
    
    func perform<T>(_ comicsCompletion: ComicsCompletion, withSuccess response: T, byIndex index: Int) {
        switch comicsCompletion {
        case .getComics:
            getFavoriteComicsCompletions[index](.success(data: response as! [Comic]))
        case .addComic:
            addFavoriteComicCompletions[index](.success(data: response as! Bool))
        case .removeComic:
            removeFavoriteComicCompletions[index](.success(data: response as! Bool))
        case .getComic:
            getFavoriteComicCompletions[index](.success(data: response as? Comic))
        }
    }
    
    func perform(_ comicsCompletion: ComicsCompletion, withError error: LocalError, byIndex index: Int) {
        switch comicsCompletion {
        case .getComics:
            getFavoriteComicsCompletions[index](.failure(error: error))
        case .addComic:
            addFavoriteComicCompletions[index](.failure(error: error))
        case .removeComic:
            removeFavoriteComicCompletions[index](.failure(error: error))
        case .getComic:
            getFavoriteComicCompletions[index](.failure(error: error))
        }
    }
    
}
