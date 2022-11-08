//
//  ComicDetailViewModel.swift
//  MarvelComics
//
//  Created by Iram Martinez on 07/11/22.
//

import Foundation
import Data
import UseCase
import Domain
import Combine

class ComicDetailViewModel: ObservableObject {
    private let getFavoriteComicUseCase: GetFavoriteComicUseCase
    private let addFavoriteComicUseCase: AddFavoriteComicUseCase
    private let removeFavoriteComicUseCase: RemoveFavoriteComicUseCase
    var isSavedSubject = PassthroughSubject<Bool, Never>()
    var alertSubject = PassthroughSubject<AlertBody, Never>()
    
    init(getFavoriteComicUseCase: GetFavoriteComicUseCase, addFavoriteComicUseCase: AddFavoriteComicUseCase, removeFavoriteComicUseCase: RemoveFavoriteComicUseCase) {
        self.getFavoriteComicUseCase = getFavoriteComicUseCase
        self.addFavoriteComicUseCase = addFavoriteComicUseCase
        self.removeFavoriteComicUseCase = removeFavoriteComicUseCase
    }
    
    func checkIsSavedComic(comicId: Int) {
        self.getFavoriteComicUseCase.invoke(byId: comicId) { [weak self] (result: LocalResult<Comic?>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.isSavedSubject.send(data != nil)
                case .failure(let _):
                    self?.isSavedSubject.send(false)
                }
            }
        }
    }
    
    func addToFavorites(comic: Comic) {
        self.addFavoriteComicUseCase.invoke(comic: comic) { [weak self] (result: LocalResult<Bool>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if data {
                        self?.checkIsSavedComic(comicId: comic.id)
                    }
                    self?.alertSubject.send(AlertBody(shouldShow: data, title: data ? "Comic added to favorites" : "Could not added comic to favorites"))
                case .failure(_):
                    self?.alertSubject.send(AlertBody(shouldShow: true, title: "There was a problem adding the comic to favorites. Try again"))
                }
            }
            
        }
    }
    
    func removeFromFavorites(comicId: Int) {
        self.removeFavoriteComicUseCase.invoke(byId: comicId) { [weak self] (result: LocalResult<Bool>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if data {
                        self?.checkIsSavedComic(comicId: comicId)
                    }
                    self?.alertSubject.send(AlertBody(shouldShow: data, title: data ? "Comic removed to favorites" : "Comic could not remove comic from favorites"))
                case .failure(_):
                    self?.alertSubject.send(AlertBody(shouldShow: true, title: "There was a problem removing the comic to favorites. Try again"))
                }
            }
        }
    }
}
