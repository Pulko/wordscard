//
//  WordsListView.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import SwiftUI

struct WordsListView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @EnvironmentObject private var mainViewModel: HomeViewModel
  
  @State private var word = ""
  @State private var translation = ""
  @State private var info = ""
  
  private func addNewWordCallback() {
    word.removeAll()
    translation.removeAll()
    info.removeAll()
  }
  
  var body: some View {
    GeometryReader { geometry in
      VStack {
        Spacer(minLength: geometry.size.height / 4)
        if #available(iOS 16.0, *) {
          form
            .scrollContentBackground(.hidden)
            .foregroundColor(Color(uiColor: UIColor(named: "Text")!))
          
        } else {
          form
            .foregroundColor(Color(uiColor: UIColor(named: "Text")!))
        }
        
        HStack {
          backButton
          Spacer()
          addNewWordButton
        }
        .padding(.horizontal, geometry.size.width / 10)
      }
    }
    .banner(data: $mainViewModel.notification, show: $mainViewModel.showNotification)
    .navigationBarBackButtonHidden()
    .onAppear {
      UITableView.appearance().backgroundColor = .clear
    }
  }
}

extension WordsListView {
  private var form: some View {
    Form {
      Section("Word") {
        if #available(iOS 16.0, *) {
          TextField("e.g. Hallo!", text: $word)
            .italic(word.isEmpty)
        } else {
          TextField("e.g. Hallo!", text: $word)
          
        }
      }
      
      Section("Translation") {
        if #available(iOS 16.0, *) {
          TextField("e.g. Hello!", text: $translation)
            .italic(translation.isEmpty)
        } else {
          TextField("e.g. Hello!", text: $translation)
        }
      }
      
      Section("Description (optional)") {
        if #available(iOS 16.0, *) {
          TextField("e.g. a greeting in German", text: $info)
            .italic(info.isEmpty)
        } else {
          TextField("e.g. a greeting in German", text: $info)
        }
      }
    }
  }
  private var backButton: some View {
    StyledButton(content: Text("Back"), foregroundColor: Color(uiColor: UIColor(named: "Text")!), backgroundColor: Color(uiColor: UIColor(named: "Color")!), lineWidth: 4) {
      presentationMode.wrappedValue.dismiss()
    }
  }
  
  private var addNewWordButton: some View {
    StyledButton(content: Text("Add new"), foregroundColor: Color(uiColor: UIColor(named: "Color")!), backgroundColor: Color(uiColor: UIColor(named: "Background")!), lineWidth: 0) {
      mainViewModel.addNewWord(word: word, translation: translation, info: info, callback: addNewWordCallback)
    }
  }
}

struct WordsListView_Previews: PreviewProvider {
  static var previews: some View {
    WordsListView()
      .environmentObject(dev.homeVM)
  }
}
