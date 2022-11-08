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
    var alertSubject = PassthroughSubject<AlertBody, Never>()
    var fetchingSubject = PassthroughSubject<Bool, Never>()
    
    init(getFavoriteComicsUseCase: GetFavoriteComicsUseCase) {
        self.getFavoriteComicsUseCase = getFavoriteComicsUseCase
    }
    
    func fetchComics() {
        fetchingSubject.send(true)
        getFavoriteComicsUseCase.invoke { [weak self] (result: LocalResult<[Comic]>) in
            DispatchQueue.main.async {
                self?.fetchingSubject.send(false)
                switch result {
                case .success(let data):
                    self?.comicsSubject.send(data)
                case .failure(_):
                    self?.alertSubject.send(AlertBody(shouldShow: true, title: "There was an error loading the comics"))
                    self?.comicsSubject.send([])
                }
            }
        }
    }
}
