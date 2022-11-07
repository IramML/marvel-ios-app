//
//  ComicsView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI
import UseCase
import Data
import Domain
import RequestManager

struct ComicsView: View {
    @ObservedObject private var comicsViewModel: ComicsViewModel
    
    @State var comics: [Comic] = []
    @State var path: [Comic] = []
    
    init() {
        let remoteDS = ComicsRequester()
        let localDS = LocalDSTemp()
        let repository = ComicsRepository(comicsRemoteDataSource: remoteDS, comicsLocalDataSource: localDS)
        let getComicsUseCase = GetComicsUseCase(comicsRepository: repository)
        self.comicsViewModel = ComicsViewModel(getComicsUseCase: getComicsUseCase)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                ComicsListView(comics: $comics, title: "Comics") { comics in
                    path = [comics]
                }
            }
            .navigationDestination(for: Comic.self) { comic in
                ComicDetailView(comic: comic)
            }
        }
        .onReceive(comicsViewModel.comicsSubject, perform: { comicsOutput in
            comics = comicsOutput
        })
        .onAppear {
            comicsViewModel.fetchComics()
        }
    }
}

struct ComicsView_Previews: PreviewProvider {
    static let anyComic = Comic(id: 3627, digitalId: 0, title: "Storm (2006)", issueNumber: 0, variantDescription: "", description: "", modified: "2015-01-29T20:04:55-0500", isbn: "", diamondCode: "", format: "Comic", pageCount: 0, textObjects: [ComicTextObject(type: "issue_solicit_text", language: "en-us", text: "The epic, untold love story between Marvel's two pre-eminent Black super heroes -- Storm and the Black Panther -- is finally told, as only New York Times best-selling author Eric Jerome Dickey can do it!  An orphaned street urchin, living by her wits on the unforgiving plains of Africa as she struggles to harness her slowly-developing mutant powers...A warrior Prince, embarking on his rite of passage as he ponders the great responsibility in his future...And a crew of ruthless mercenaries who'll stop at nothing to capture an elusive creature of legend -- the fabled wind-rider.  What sparks occur when their paths intersect?  Don't miss out on this story, True Believer, as it builds to a July Event that will shake the entire Marvel Universe.\r<br>\r<br>32 PGS./T+ SUGGESTED FOR TEENS AND UP ...$2.99\r<br>")], series: ComicResource(resourceURI: "http://gateway.marvel.com/v1/public/series/357", name: "Storm (2006)"), variants: [], collections: [], collectedIssues: [], dates: [], prices: [], thumbnail: ComicImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/4bc5fe7a308d7", extensionImg: "jpg"), images: [ComicImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/4bc5fe7a308d7", extensionImg: "jpg")], creators: ComicCreators(available: 3, returned: 3, collectionURI: "http://gateway.marvel.com/v1/public/comics/3627/creators", items: []))
    static var previews: some View {
        ComicsView()
    }
}

class LocalDSTemp: ComicsLocalDataSource {
    func getFavoriteComics(completion: @escaping (RemoteResult<[Comic]>) -> Void) {
        
    }
    
    func getFavoriteComic(byId comicId: Int, completion: @escaping (RemoteResult<Comic?>) -> Void) {
        
    }
    
    func addFavoriteComic(_ comic: Comic, completion: @escaping (RemoteResult<Bool>) -> Void) {
        
    }
    
    func removeFavoriteComic(byId comicId: Int, completion: @escaping (RemoteResult<Bool>) -> Void) {
        
    }
    
    
}
