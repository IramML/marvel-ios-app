//
//  ComicsRemoteDataSource.swift
//  Data
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Domain

public protocol ComicsRemoteDataSource {
    func getComics(completion: @escaping (RemoteResult<[Comic]>) -> Void)
}
