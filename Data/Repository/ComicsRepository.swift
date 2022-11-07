//
//  ComicsRepository.swift
//  Data
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Domain

final class ComicsRepository {
    private let comicsRemoteDataSource: ComicsRemoteDataSource
    private let comicsLocalDataSource: ComicsLocalDataSource
    
    init(comicsRemoteDataSource: ComicsRemoteDataSource, comicsLocalDataSource: ComicsLocalDataSource) {
        self.comicsRemoteDataSource = comicsRemoteDataSource
        self.comicsLocalDataSource = comicsLocalDataSource
    }
    
    func getComics(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        self.comicsRemoteDataSource.getComics(completion: completion)
    }
    
    func getFavoriteComics(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        comicsLocalDataSource.getFavoriteComics(completion: completion)
    }
    
    func getFavoriteComic(byId comicId: Int, completion: @escaping (RemoteResult<Comic?>) -> Void) {
        comicsLocalDataSource.getFavoriteComic(byId: comicId, completion: completion)
    }
    
    func addFavoriteComic(comic: Comic, completion: @escaping (RemoteResult<Bool>) -> Void) {
        comicsLocalDataSource.addFavoriteComic(comic, completion: completion)
    }
    
    func removeFavoriteComic(byId comicId: Int, completion: @escaping (RemoteResult<Bool>) -> Void) {
        comicsLocalDataSource.removeFavoriteComic(byId: comicId, completion: completion)
    }
}
