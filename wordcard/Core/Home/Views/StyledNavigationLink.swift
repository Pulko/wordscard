//
//  StyledNavigationLink.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import SwiftUI

struct StyledNavigationLink<Content: View>: View {
  var title: String
  var view: Content
  var foregroundColor: Color
  var backgroundColor: Color
  var padding: CGFloat = 20
  
  init(title: String, foregroundColor: Color, backgroundColor: Color, padding: CGFloat = 20, view: @escaping () -> Content) {
    self.title = title
    self.view = view()
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
    self.padding = padding
  }
  
  var body: some View {
    if #available(iOS 16.0, *) {
      NavigationLink(title) {
        view
      }
      .padding(padding)
      .foregroundColor(foregroundColor)
      .fontWidth(.expanded)
      .fontWeight(.bold)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .foregroundColor(backgroundColor)
      )
    } else {
      // Fallback on earlier versions
      NavigationLink(title) {
        view
      }
      .padding(padding)
      .foregroundColor(foregroundColor)
      .font(.body.weight(.bold))
      .background(
        RoundedRectangle(cornerRadius: 16)
          .foregroundColor(backgroundColor)
      )
    }
  }
}

struct StyledNavigationLink_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      StyledNavigationLink(title: "Hello World!", foregroundColor: .white, backgroundColor: .black, padding: 28) {
        Text("Hello again!")
      }
    }
  }
}
