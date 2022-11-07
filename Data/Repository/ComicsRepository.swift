//
//  ComicsRepository.swift
//  Data
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Domain

public final class ComicsRepository {
    private let comicsRemoteDataSource: ComicsRemoteDataSource
    private let comicsLocalDataSource: ComicsLocalDataSource
    
    public init(comicsRemoteDataSource: ComicsRemoteDataSource, comicsLocalDataSource: ComicsLocalDataSource) {
        self.comicsRemoteDataSource = comicsRemoteDataSource
        self.comicsLocalDataSource = comicsLocalDataSource
    }
    
    public func getComics(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        self.comicsRemoteDataSource.getComics(completion: completion)
    }
    
    public func getFavoriteComics(completion: @escaping (LocalResult<[Comic]>) -> Void) {
        comicsLocalDataSource.getFavoriteComics(completion: completion)
    }
    
    public func getFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Comic?>) -> Void) {
        comicsLocalDataSource.getFavoriteComic(byId: comicId, completion: completion)
    }
    
    public func addFavoriteComic(comic: Comic, completion: @escaping (LocalResult<Bool>) -> Void) {
        comicsLocalDataSource.addFavoriteComic(comic, completion: completion)
    }
    
    public func removeFavoriteComic(byId comicId: Int, completion: @escaping (LocalResult<Bool>) -> Void) {
        comicsLocalDataSource.removeFavoriteComic(byId: comicId, completion: completion)
    }
}
