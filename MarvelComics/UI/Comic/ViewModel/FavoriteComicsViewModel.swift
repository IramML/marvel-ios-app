//
//  FavoriteComicsViewModel.swift
//  MarvelComics
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import UseCase
import Domain
import Combine
import Data

class FavoriteComicsViewModel: ObservableObject {
    private let getFavoriteComicsUseCase: GetFavoriteComicsUseCase
    var comicsSubject = PassthroughSubject<[Comic], Never>()
    
    init(getFavoriteComicsUseCase: GetFavoriteComicsUseCase) {
        self.getFavoriteComicsUseCase = getFavoriteComicsUseCase
    }
    
    func fetchComics() {
        getFavoriteComicsUseCase.invoke { [weak self] (result: LocalResult<[Comic]>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.comicsSubject.send(data)
                case .failure(let error):
                    //fatalError("Got error \(error)")
                    break
                }
            }
        }
    }
}
