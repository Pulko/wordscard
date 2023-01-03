//
//  Word.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 01.01.23.
//

import Foundation

struct Word: Identifiable, Codable {
  let id: UUID
  var word: String
  var translation: String
  var info: String?
}
