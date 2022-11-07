//
//  ComicsView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI
import Domain

struct ComicsView: View {
    @State var comics: [Comic] = []
    
    var body: some View {
        ScrollView {
            ComicsListView(comics: $comics, title: "Comics") { _ in
                
            }
        }
    }
}

struct ComicsView_Previews: PreviewProvider {
    static let anyComic = Comic(id: 3627, digitalId: 0, title: "Storm (2006)", issueNumber: 0, variantDescription: "", description: "", modified: "2015-01-29T20:04:55-0500", isbn: "", diamondCode: "", format: "Comic", pageCount: "0", textObjects: ComicTextObject(type: "issue_solicit_text", language: "en-us", text: "The epic, untold love story between Marvel's two pre-eminent Black super heroes -- Storm and the Black Panther -- is finally told, as only New York Times best-selling author Eric Jerome Dickey can do it!  An orphaned street urchin, living by her wits on the unforgiving plains of Africa as she struggles to harness her slowly-developing mutant powers...A warrior Prince, embarking on his rite of passage as he ponders the great responsibility in his future...And a crew of ruthless mercenaries who'll stop at nothing to capture an elusive creature of legend -- the fabled wind-rider.  What sparks occur when their paths intersect?  Don't miss out on this story, True Believer, as it builds to a July Event that will shake the entire Marvel Universe.\r<br>\r<br>32 PGS./T+ SUGGESTED FOR TEENS AND UP ...$2.99\r<br>"), series: ComicResource(resourceURI: "http://gateway.marvel.com/v1/public/series/357", name: "Storm (2006)"), variants: [], collections: [], collectedIssues: [], dates: [], prices: [], thumbnail: ComicImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/4bc5fe7a308d7", extensionImg: "jpg"), images: [ComicImage(path: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/4bc5fe7a308d7", extensionImg: "jpg")], creators: ComicCreators(available: 3, returned: 3, collectionURI: "http://gateway.marvel.com/v1/public/comics/3627/creators", items: []))
    static var previews: some View {
        ComicsView()
    }
}
