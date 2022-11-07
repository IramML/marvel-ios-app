//
//  GetComicsUseCase.swift
//  UseCase
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Data
import Domain

public final class GetComicsUseCase {
    private let comicsRepository: ComicsRepository
    
    public init(comicsRepository: ComicsRepository) {
        self.comicsRepository = comicsRepository
    }
    
    public func invoke(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        comicsRepository.getComics(completion: completion)
    }
}
