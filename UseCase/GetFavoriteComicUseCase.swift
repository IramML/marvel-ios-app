//
//  GetFavoriteComicUseCase.swift
//  UseCase
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Data
import Domain

public final class GetFavoriteComicUseCase {
    private let comicsRepository: ComicsRepository
    
    public init(comicsRepository: ComicsRepository) {
        self.comicsRepository = comicsRepository
    }
    
    public func invoke(byId comicId: Int, completion: @escaping (LocalResult<Comic?>) -> Void) {
        comicsRepository.getFavoriteComic(byId: comicId, completion: completion)
    }
}
