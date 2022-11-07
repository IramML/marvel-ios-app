//
//  ComicDetailView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 07/11/22.
//

import SwiftUI
import Domain

struct ComicDetailView: View {
    var comic: Comic
    @State var isSaved: Bool? = nil
    
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
            
            if let isSaved = isSaved {
                AccentButtonView(title: isSaved ? "Remove from favorites" : "Add to favorites") {
                    
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
    }
}

struct ComicDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ComicDetailView(comic: ComicsView_Previews.anyComic)
    }
}
