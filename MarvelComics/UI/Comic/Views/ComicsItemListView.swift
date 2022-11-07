//
//  ComicsItemListView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI
import Domain

struct ComicsItemListView: View {
    var comic: Comic
    var comicSelected: (Comic) -> Void
    
    var body: some View {
        VStack {
            Button {
                comicSelected(comic)
            } label: {
                CacheAsyncImage(url: URL(string: "\(comic.thumbnail.path.replacingOccurrences(of: "http", with: "https")).\(comic.thumbnail.extensionImg)")!) { image in
                    image.image?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(8)
                    }
                    .frame(width: 130, height: 250)
                    .padding(.horizontal, 16)
                
                
            }

            
        }
    }

}

struct ComicsItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsItemListView(comic: ComicsView_Previews.anyComic) { _ in
            
        }
    }
}
