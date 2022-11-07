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
    private var getComicsCompletions: [(RemoteResult<[Comic]>) -> Void] = []
    private var addComicCompletions: [(RemoteResult<Bool>) -> Void] = []
    private var removeComicCompletions: [(RemoteResult<Bool>) -> Void] = []
    
    enum ComicsCompletion {
        case getComics
        case addComic
        case removeComic
    }
    
    func getComics(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        comicsCompletions.append(.getComics)
        getComicsCompletions.append(completion)
    }
    
    func addComic(_ comic: Domain.Comic, completion: @escaping (RemoteResult<Bool>) -> Void) {
        comicsCompletions.append(.addComic)
        addComicCompletions.append(completion)
    }
    
    func removeComic(byId comicId: Int, completion: @escaping (RemoteResult<Bool>) -> Void) {
        comicsCompletions.append(.removeComic)
        removeComicCompletions.append(completion)
    }
    
    func perform<T>(_ comicsCompletion: ComicsCompletion, withSuccess response: T, byIndex index: Int) {
        switch comicsCompletion {
        case .getComics:
            getComicsCompletions[index](.success(data: response as! [Comic]))
        case .addComic:
            addComicCompletions[index](.success(data: response as! Bool))
        case .removeComic:
            removeComicCompletions[index](.success(data: response as! Bool))
        }
    }
    
    func perform(_ comicsCompletion: ComicsCompletion, withError error: RemoteError, byIndex index: Int) {
        switch comicsCompletion {
        case .getComics:
            getComicsCompletions[index](.failure(error: error))
        case .addComic:
            addComicCompletions[index](.failure(error: error))
        case .removeComic:
            removeComicCompletions[index](.failure(error: error))
        }
    }
    
}
