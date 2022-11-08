//
//  ComicsListView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI
import Domain

struct ComicsListView: View {
    @Binding var comics: [Comic]
    var title: String
    var comicSelected: (Comic) -> Void
    
    let gridShape = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]

    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .padding(.top, 16.0)
                .padding(.horizontal, 16.0)
            ScrollView {
                LazyVGrid(columns: gridShape) {
                    ForEach(comics, id: \.id) { comic in
                        ComicsItemListView(comic: comic, comicSelected: comicSelected)
                    }
                }
            }
            
        }

    }
}

struct ComicsListView_Previews: PreviewProvider {
    @State static var comics: [Comic] = []
    static var previews: some View {
        ComicsListView(comics: $comics, title: "Comics") { _ in
            
        }
    }
}
