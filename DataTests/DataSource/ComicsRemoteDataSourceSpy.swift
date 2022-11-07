//
//  ComicsRemoteDataSourceSpy.swift
//  DataTests
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
@testable import Data
import Domain

final class ComicsRemoteDataSourceSpy: ComicsRemoteDataSource {
    private(set) var getComicsCompletions: [(RemoteResult<[Comic]>) -> Void] = []
    
    func getComics(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        getComicsCompletions.append(completion)
    }
    
    func performGetComics(withSuccess response: [Comic], byIndex index: Int) {
        getComicsCompletions[index](.success(data: response))
    }
    
    func performGetComics( withError error: RemoteError, byIndex index: Int) {
        getComicsCompletions[index](.failure(error: error))
    }
}
