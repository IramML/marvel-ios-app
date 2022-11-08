//
//  MarvelComicsApp.swift
//  MarvelComics
//
//  Created by Iram Martinez on 06/11/22.
//

import SwiftUI
import DatabaseManager

@main
struct MarvelComicsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
