//
//  PlayView.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import SwiftUI

struct PlayView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @EnvironmentObject private var mainViewModel: HomeViewModel
  
  @State private var currentWord: Word? = nil
  @State private var translationExposed = false
  
  private func getRandomWord() -> Void {
    withAnimation {
      currentWord = mainViewModel.getRandomWord()
    }
  }
  
  private func swipeNextWord() -> Void {
    withAnimation {
      getRandomWord()
      translationExposed = false
    }
  }
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer(minLength: geometry.size.height / 4)
        
        if let content = currentWord {
          VStack(alignment: .leading) {
            HStack {
              Spacer()
              Text(content.word)
                .styledView(foregroundColor: Color(uiColor: UIColor(named: "Text")!), font: .title)
              Spacer()
            }
            
            HStack {
              Spacer()
              
              HStack {
                if (translationExposed) {
                  Text(content.translation)
                } else {
                  Image(systemName: "eye.slash")
                }
              }
              .styledView(foregroundColor: Color(uiColor: UIColor(named: "Color")!), font: .title2)
              .background(Color(uiColor: UIColor(named: "Background")!))
              
              Spacer()
            }
            .padding(.vertical)
            Text(content.info ?? "")
              .styledView(foregroundColor: Color(uiColor: UIColor(named: "SecondaryText")!), font: .caption)
              .padding(.horizontal)
              .lineLimit(5)
          }
          .frame(width: geometry.size.width)
          .onTapGesture {
            withAnimation {
              translationExposed.toggle()
            }
          }
          
        }
        
        Spacer()
        
        HStack {
          backButton
          Spacer()
          nextWordButton
        }
        .padding(.horizontal, geometry.size.width / 10)
      }
    }
    .contentShape(Rectangle())
    .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
      .onEnded { value in
        switch(value.translation.width, value.translation.height) {
        case (...0, -30...30):  swipeNextWord()
        default: do {}
        }
      }
    )
    .banner(data: $mainViewModel.notification, show: $mainViewModel.showNotification, delay: mainViewModel.notificationDelay)
    .navigationBarBackButtonHidden()
    .task {
      swipeNextWord()
    }
    .onAppear {
      mainViewModel.showRules()
    }
  }
}

extension PlayView {
  private var exposeTranslationButton: some View {
    HStack {
      StyledButton(
        content: Image(systemName: translationExposed ? "eye.slash" : "eye"),
        foregroundColor: Color(uiColor: UIColor(named: translationExposed ? "Text" : "Color")!),
        backgroundColor: Color(uiColor: UIColor(named: translationExposed ? "Color" : "Background")!),
        lineWidth: translationExposed ? 4 : 0
      ) {
        withAnimation {
          translationExposed.toggle()
        }
      }
    }
  }
  
  private var backButton: some View {
    StyledButton(content: Text("Back"), foregroundColor: Color(uiColor: UIColor(named: "Text")!), backgroundColor: Color(uiColor: UIColor(named: "Color")!), lineWidth: 4) {
      withAnimation {
        presentationMode.wrappedValue.dismiss()
      }
    }
  }
  
  private var nextWordButton: some View {
    StyledButton(content: Text(translationExposed ? "Next" : "Show"), foregroundColor: Color(uiColor: UIColor(named: "Color")!), backgroundColor: Color(uiColor: UIColor(named: "Background")!), lineWidth: 0) {
      withAnimation {
        if (translationExposed) {
          swipeNextWord()
        } else {
          translationExposed = true
        }
      }
    }
  }
}

struct PlayView_Previews: PreviewProvider {
  static var previews: some View {
    PlayView()
      .environmentObject(dev.homeVM)
  }
}
