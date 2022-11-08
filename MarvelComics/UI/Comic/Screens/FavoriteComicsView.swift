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
    @State var isFetching: Bool = false
    @StateObject private var alertBody: AlertBody = AlertBody()
    
    init() {
        let remoteDS = ComicsRequester()
        let localDS = ComicsDataBase()
        let repository = ComicsRepository(comicsRemoteDataSource: remoteDS, comicsLocalDataSource: localDS)
        let getFavoriteComicsUseCase = GetFavoriteComicsUseCase(comicsRepository: repository)
        self.favoriteComicsViewModel = FavoriteComicsViewModel(getFavoriteComicsUseCase: getFavoriteComicsUseCase)
    }
    
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if isFetching {
                    ProgressView()
                } else {
                    if !comics.isEmpty {
                        ScrollView {
                            ComicsListView(comics: $comics, title: "Favorites") { comics in
                                path = [comics]
                            }
                        }
                    } else {
                        Text("No comics")
                    }
                }
            }
            
            .alert(alertBody.title, isPresented: $alertBody.shouldShow) {
            }
            .onReceive(favoriteComicsViewModel.alertSubject, perform: { alertOutput in
                alertBody.title = alertOutput.title
                alertBody.shouldShow = alertOutput.shouldShow
            })
            .onReceive(favoriteComicsViewModel.comicsSubject, perform: { comicsOutput in
                comics = comicsOutput
            })
            .onReceive(favoriteComicsViewModel.fetchingSubject, perform: { isFetchingOutput in
                isFetching = isFetchingOutput
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
