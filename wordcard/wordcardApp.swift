//
//  wordcardApp.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 01.01.23.
//

import SwiftUI

@main
struct wordcardApp: App {
  @StateObject private var mainViewModel = HomeViewModel()

  var body: some Scene {
    WindowGroup {
      HomeView()
        .environmentObject(mainViewModel)
    }
  }
}
