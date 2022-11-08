//
//  AccentButtonView.swift
//  MarvelComics
//
//  Created by Iram Martinez on 07/11/22.
//

import SwiftUI

struct AccentButtonView: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(role: .none) {
            action()
        } label: {
            Text(title)
                .foregroundColor(.white)
        }
        .buttonStyle(.bordered)
        .controlSize(.regular)
        .tint(Color.accentColor)

        
    }
}

struct AccentButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AccentButtonView(title: "Title") {
            
        }
    }
}
