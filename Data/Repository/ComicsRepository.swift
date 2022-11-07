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
}
