//
//  AddFavoriteComicUseCase.swift
//  UseCase
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Data
import Domain

public final class AddFavoriteComicUseCase {
    private let comicsRepository: ComicsRepository
    
    public init(comicsRepository: ComicsRepository) {
        self.comicsRepository = comicsRepository
    }
    
    public func invoke(comic: Comic, completion: @escaping (LocalResult<Bool>) -> Void) {
        comicsRepository.addFavoriteComic(comic: comic, completion: completion)
    }
}
