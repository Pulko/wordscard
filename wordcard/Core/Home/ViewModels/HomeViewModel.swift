//
//  HomeViewModel.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 01.01.23.
//

import Foundation
import SwiftUI
import Combine

struct WordInitial: Codable {
  var word: String
  var translation: String
  var info: String
}

struct InitialData: Codable {
  var words: [WordInitial]
}

class HomeViewModel: ObservableObject {
  @Published var isLoading: Bool = false
  @Published var words: [Word] = []
  @Published var error: String = ""
  
  @Published var notification: Notification = Notification(title: "Welcome!", detail: "Have fun finding what you like!", type: .Success)
  @Published var showNotification = false
  @Published var notificationDelay: CGFloat = 2
  
  private let wordStorageService = Storage()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubscribers()
  }
  
  // MARK: API
  
  func addNewWord(word: String, translation: String, info: String, callback: () -> Void = {}) {
    notificationDelay = 2
    
    if !word.isEmpty && !translation.isEmpty && !info.isEmpty {
      self.addWord(word: word, translation: translation, info: info)
      
      self.notification = Notification(title: "New word is added!", detail: "This word is available to play with", type: .Success)
      callback()
    } else {
      self.notification = Notification(title: "Error!", detail: "Word and its translation are required", type: .Error)
    }
    
    self.showNotification = true
  }
  
  func getRandomWord() -> Word? {
    words.randomElement()
  }
  
  func showRules() -> Void {
    self.notification = Notification(title: "Tips", detail: "Click anywhere on text to expose the translation of the current word and swipe left to get next random word or use button in the very bottom", type: .Info)
    self.notificationDelay = 5
    self.showNotification = true
  }
  
  func loadInitialData() -> Void {
    if words.isEmpty {
      let data = Bundle.main.decode(InitialData.self, from: "initial.json")
      
      data.words.forEach { word in
        addWord(word: word.word, translation: word.translation, info: word.info)
      }
    }
  }
  
  // MARK: Private functions
  
  private func addSubscribers() {
    wordStorageService.$error
      .sink { [weak self] (error: String?) in
        if let errorUnwrapped = error {
          self?.error = errorUnwrapped
        }
      }
      .store(in: &cancellables)
    
    wordStorageService.$entities
      .sink { [weak self] (entities: [WordEntity]) in
        self?.words.removeAll()
        
        entities.forEach { entity in
          if entity.id != nil, entity.word != nil , entity.translation != nil {
            self?.words.append(
              Word(
                id: entity.id!,
                word: entity.word!,
                translation: entity.translation!,
                info: entity.info ?? ""
              )
            )
            
          }
        }
      }
      .store(in: &cancellables)
  }
  
  private func addWord(word: String, translation: String, info: String? = "") {
    let word = Word(id: UUID(), word: word, translation: translation, info: info)
    
    wordStorageService.add(word)
  }
  
  private func deleteWord(id: UUID) {
    wordStorageService.delete(id: id)
  }
  
  private func updateWord(id: UUID, word: String, translation: String, info: String? = "") {
    let word = Word(id: UUID(), word: word, translation: translation, info: info)
    
    wordStorageService.update(id: id, word: word)
  }
  
  private func refetchWords() {
    wordStorageService.refetch()
  }
  
  private func flushWords() {
    wordStorageService.flush()
  }
}
