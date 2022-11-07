//
//  ComicsLocalDataSource.swift
//  Data
//
//  Created by Iram Martinez on 06/11/22.
//

import Foundation
import Domain

public protocol ComicsLocalDataSource {
    func getComics(completion: @escaping (RemoteResult<[Comic]>) -> Void)
    func addComic(_ comic: Comic, completion: @escaping (RemoteResult<Bool>) -> Void)
    func removeComic(byId comicId: Int, completion: @escaping (RemoteResult<Bool>) -> Void)
}
