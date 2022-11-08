//
//  ComicDetailView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 07/11/22.
//

import SwiftUI
import Domain
import RequestManager
import DatabaseManager
import Data
import UseCase

struct ComicDetailView: View {
    @StateObject var comicDetailViewModel: ComicDetailViewModel
    var comic: Comic
    @State var isSaved: Bool? = nil
    
    init(comic: Comic) {
        self.comic = comic
        let remoteDS = ComicsRequester()
        let localDS = ComicsDataBase()
        let repository = ComicsRepository(comicsRemoteDataSource: remoteDS, comicsLocalDataSource: localDS)
        let getFavoriteComicUseCase = GetFavoriteComicUseCase(comicsRepository: repository)
        let addFavoriteComicUseCase = AddFavoriteComicUseCase(comicsRepository: repository)
        let removeFavoriteComicUseCase = RemoveFavoriteComicUseCase(comicsRepository: repository)
        _comicDetailViewModel = StateObject(wrappedValue: ComicDetailViewModel(getFavoriteComicUseCase: getFavoriteComicUseCase, addFavoriteComicUseCase: addFavoriteComicUseCase, removeFavoriteComicUseCase: removeFavoriteComicUseCase))
    }
    
    var body: some View {
        ScrollView {
            CacheAsyncImage(url: URL(string: "\(comic.thumbnail.path.replacingOccurrences(of: "http", with: "https")).\(comic.thumbnail.extensionImg)")!) { image in
                image.image?
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .frame(width: 130, height: 250)
                }
                .frame(width: 130, height: 250)
                .padding(.horizontal, 16)
                
            Text(comic.title)
                .font(.title.bold())
            
            if let isSavedComic = isSaved {
                AccentButtonView(title: isSavedComic ? "Remove from favorites" : "Add to favorites") {
                    if isSavedComic {
                        comicDetailViewModel.removeFromFavorites(comicId: comic.id)
                    } else {
                        comicDetailViewModel.addToFavorites(comic: comic)
                    }
                    isSaved = nil
                    
                }
            } else {
                ProgressView()
            }
                
            VStack(alignment: .leading) {
                Text("Description")
                    .bold()
                Text(comic.description)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
              )
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .onReceive(comicDetailViewModel.isSavedSubject, perform: { isSavedOutput in
            isSaved = isSavedOutput
        })
        .onAppear {
            comicDetailViewModel.checkIsSavedComic(comicId: comic.id)
        }
    }
    
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailView(comic: ComicsView_Previews.anyComic)
    }
}
