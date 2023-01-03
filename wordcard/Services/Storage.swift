//
//  Storage.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 01.01.23.
//

import Foundation
import CoreData
import Combine

class Storage {
  private let container: NSPersistentContainer
  
  private let wordsContainerName: String = "WordContainer"
  private let wordsEntityName: String = "WordEntity"
  
  @Published var entities: [WordEntity] = []
  @Published var error: String? = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    container = NSPersistentContainer(name: wordsContainerName)
    
    container.loadPersistentStores {_,_ in
      self.error = "Failed to load store"
    }
    
    self.fetch()
  }
  
  func update(id: UUID, word: Word) {
    refreshError()
    delete(id: id)
    add(word)
    save()
  }
  
  func refetch() -> Void {
    refreshError()
    self.fetch()
  }
  
  func add(_ word: Word) -> Void {
    refreshError()
    let entity: WordEntity = generateWordEntity()
    
    assignToEntity(entity: entity, word: word)
    
    save()
    refetch()
  }
  
  func delete(id: UUID) -> Void {
    refreshError()
    let entity = entities.first { $0.id == id }
    
    if let entityUnwrapped = entity {
      deleteFromStorage(entityUnwrapped)
      save()
    }
  }
  
  func flush() -> Void {
    refreshError()
    entities.forEach { deleteFromStorage($0) }
    entities.removeAll()
    
    save()
  }
  
  private func refreshError() {
    if let error = self.error, !error.isEmpty {
      self.error = ""
    }
  }
  
  private func deleteFromStorage(_ entity: WordEntity) {
    container.viewContext.delete(entity)
  }
  
  private func generateWordEntity() -> WordEntity {
    return WordEntity(context: container.viewContext)
  }
  
  private func assignToEntity(entity: WordEntity, word: Word) -> Void {
    entity.id = word.id
    entity.info = word.info
    entity.translation = word.translation
    entity.word = word.word
  }
  
  private func fetch() -> Void {
    let request = NSFetchRequest<WordEntity>(entityName: wordsEntityName)
    
    do {
      entities = try container.viewContext.fetch(request)
    } catch _ {
      self.error = "Failed to fetch entities from store"
    }
  }
  
  private func save() {
    do {
      try container.viewContext.save()
    } catch _ {
      self.error = "Failed to save entities to store"
    }
  }
}

