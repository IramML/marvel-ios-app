//
//  HomeView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            ComicsView()
                .tabItem {
                    Label("Comics", systemImage: "list.dash")
                }

            FavoriteComicsView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
        }.onAppear {
            print("\(ComicsView_Previews.anyComic.thumbnail.path).\(ComicsView_Previews.anyComic.thumbnail.extensionImg)")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
