//
//  wordcardApp.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 01.01.23.
//

import SwiftUI

@main
struct wordcardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
