//
//  PreviewProvider.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import Foundation
import SwiftUI

extension PreviewProvider {
  static var dev: DeveloperPreview {
    return DeveloperPreview.instance
  }
}

class DeveloperPreview {
  static let instance =  DeveloperPreview()
  let homeVM: HomeViewModel

  private init() {
    homeVM = HomeViewModel()
    
    homeVM.addNewWord(word: "Arbeiterunfallversicherungsgesetz", translation: "Workers' Compensation Insurance Act", info: "Esistono innumerevoli variazioni dei passaggi del Lorem Ipsum, ma la maggior parte hanno subito delle variazioni del tempo, a causa dell’inserimento di passaggi ironici, o di sequenze casuali di caratteri palesemente poco verosimili. Se si decide di utilizzare un passaggio del Lorem Ipsum, è bene essere certi che non contenga nulla di imbarazzante. In genere, i generatori di testo segnaposto disponibili su internet tendono a ripetere paragrafi predefiniti, rendendo questo il primo vero generatore automatico su intenet")
  }
}


