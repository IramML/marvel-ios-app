//
//  ComicsViewModel.swift
//  MarvelComics
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import UseCase
import Combine
import Data
import Domain

class ComicsViewModel: ObservableObject {
    private let getComicsUseCase: GetComicsUseCase
    var comicsSubject = PassthroughSubject<[Comic], Never>()
    var alertSubject = PassthroughSubject<AlertBody, Never>()
    
    init(getComicsUseCase: GetComicsUseCase) {
        self.getComicsUseCase = getComicsUseCase
    }
    
    func fetchComics() {
        self.getComicsUseCase.invoke { [weak self] (result: RemoteResult<[Comic]>) in
            DispatchQueue.main.async {
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
