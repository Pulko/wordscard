//
//  StyledText.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import Foundation
import SwiftUI

struct TextModifier: ViewModifier {
  var foregroundColor: Color
  var font: Font
  
  func body(content: Content) -> some View {
    ZStack {
      if #available(iOS 16.0, *) {
        content
          .padding()
          .foregroundColor(foregroundColor)
          .fontWidth(.expanded)
          .fontWeight(.bold)
          .textFieldStyle(.roundedBorder)
          .font(font)
      } else {
        // Fallback on earlier versions
        content
          .padding()
          .foregroundColor(foregroundColor)
          .font(.body.weight(.bold))
          .textFieldStyle(.roundedBorder)
          .font(font)
      }
    }
  }
  
}

extension View {
  func styledView(foregroundColor: Color, font: Font) -> some View {
    self.modifier(TextModifier(foregroundColor: foregroundColor, font: font))
  }
}
