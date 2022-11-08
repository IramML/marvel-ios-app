//
//  FavoriteComicsView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI
import UseCase
import Data
import Domain
import RequestManager
import DatabaseManager

struct FavoriteComicsView: View {
    @ObservedObject private var favoriteComicsViewModel: FavoriteComicsViewModel
    
    @State var comics: [Comic] = []
    @State var path: [Comic] = []
    
    init() {
        let remoteDS = ComicsRequester()
        let localDS = ComicsDataBase()
        let repository = ComicsRepository(comicsRemoteDataSource: remoteDS, comicsLocalDataSource: localDS)
        let getFavoriteComicsUseCase = GetFavoriteComicsUseCase(comicsRepository: repository)
        self.favoriteComicsViewModel = FavoriteComicsViewModel(getFavoriteComicsUseCase: getFavoriteComicsUseCase)
    }
    
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                ComicsListView(comics: $comics, title: "Favorites") { comics in
                    path = [comics]
                }
            }
            .onReceive(favoriteComicsViewModel.comicsSubject, perform: { comicsOutput in
                comics = comicsOutput
            })
            .onAppear {
                favoriteComicsViewModel.fetchComics()
            }
            .navigationDestination(for: Comic.self) { comic in
                ComicDetailView(comic: comic)
            }
        }
        
    }
}

struct FavoriteComicsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteComicsView()
    }
}
