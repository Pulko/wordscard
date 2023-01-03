//
//  StyledButton.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import SwiftUI

struct StyledButton<Content: View>: View {
  var content: Content
  var action: () -> Void
  var foregroundColor: Color
  var backgroundColor: Color
  var lineWidth: CGFloat = 0
  
  init(content: Content, foregroundColor: Color, backgroundColor: Color, lineWidth: CGFloat, action: @escaping () -> Void) {
    self.content = content
    self.action = action
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
    self.lineWidth = lineWidth
  }
  
  var body: some View {
    if #available(iOS 16.0, *) {
      Button {
        action()
      } label: {
        content
      }
      .padding()
      .foregroundColor(foregroundColor)
      .fontWidth(.expanded)
      .fontWeight(.bold)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .stroke(foregroundColor, lineWidth: lineWidth)
          .background(
            RoundedRectangle(cornerRadius: 16)
              .foregroundColor(backgroundColor)
          )
      )
    } else {
      // Fallback on earlier versions
      Button {
        action()
      } label: {
        content
      }
      .padding()
      .foregroundColor(foregroundColor)
      .font(.body.weight(.bold))
      .background(
        RoundedRectangle(cornerRadius: 16)
          .stroke(foregroundColor, lineWidth: lineWidth)
          .background(
            RoundedRectangle(cornerRadius: 16)
              .foregroundColor(backgroundColor)
          )
      )
    }
  }
}

struct StyledButton_Previews: PreviewProvider {
  static var previews: some View {
    StyledButton(content: Text("Back"), foregroundColor: Color(uiColor: UIColor(named: "Color")!), backgroundColor: Color(uiColor: UIColor(named: "Text")!), lineWidth: 0) {
      {}()
    }
    .preferredColorScheme(.light)
  }
}
