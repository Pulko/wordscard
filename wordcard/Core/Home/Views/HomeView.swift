//
//  HomeView.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 01.01.23.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject private var mainViewModel: HomeViewModel
  @Environment(\.colorScheme) var colorScheme
  
  @State private var wordValue: String = ""
  @State private var translationValue: String = ""
  @State private var infoValue: String = ""
  
  
  var body: some View {
    NavigationView {
      VStack {
        if colorScheme == .dark {
          Image("logo-dark")
        }
        
        if colorScheme == .light {
          Image("logo-light")
        }
        
        Spacer()
        
        if (!mainViewModel.words.isEmpty) {
          StyledNavigationLink(title: "Play words", foregroundColor: Color(uiColor: UIColor(named: "Color")!), backgroundColor: Color(uiColor: UIColor(named: "Background")!), padding: 26) {
            PlayView()
              .environmentObject(mainViewModel)
          }
          .padding(.bottom)
        }
        
        StyledNavigationLink(title: "Add words", foregroundColor: Color(uiColor: UIColor(named: "Text")!), backgroundColor: Color(uiColor: UIColor(named: "Color")!)) {
          WordsListView()
            .environmentObject(mainViewModel)
        }
        
        Spacer()
      }
    }
    .onAppear {
      mainViewModel.loadInitialData()
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
      .environmentObject(dev.homeVM)
      .preferredColorScheme(.dark)
  }
}
