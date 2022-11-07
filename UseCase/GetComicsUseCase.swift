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
    
    init(comicsRepository: ComicsRepository) {
        self.comicsRepository = comicsRepository
    }
    
    func invoke(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        comicsRepository.getComics(completion: completion)
    }
}
