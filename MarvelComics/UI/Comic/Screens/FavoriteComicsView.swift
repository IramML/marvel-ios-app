//
//  FavoriteComicsView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI
import Domain

struct FavoriteComicsView: View {
    @State var comics: [Comic] = []
    
    var body: some View {
        ScrollView {
            ComicsListView(comics: $comics, title: "Favorites") { _ in
                
            }
        }
    }
}

struct FavoriteComicsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteComicsView()
    }
}
