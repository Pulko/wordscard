//
//  Banner.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import SwiftUI

struct BannerModifier: ViewModifier {
  // Members for the Banner
  @Binding var data: Notification
  @Binding var show: Bool
  var delay: CGFloat
  
  func body(content: Content) -> some View {
    ZStack {
      content
      if show {
        VStack {
          HStack {
            VStack(alignment: .leading, spacing: 2) {
              Text(data.title)
                .bold()
              Text(data.detail)
                .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
            }
            Spacer()
          }
          .foregroundColor(Color.white)
          .padding(12)
          .background(data.type.tintColor)
          .cornerRadius(8)
          Spacer()
        }
        .padding()
        .animation(.easeInOut, value: show)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onTapGesture {
          withAnimation {
            self.show = false
          }
        }.onAppear(perform: {
          DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            withAnimation {
              self.show = false
            }
          }
        })
      }
    }
  }
  
}

extension View {
  func banner(data: Binding<Notification>, show: Binding<Bool>, delay: CGFloat = 2) -> some View {
    self.modifier(BannerModifier(data: data, show: show, delay: delay))
  }
}

struct Banner_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Text("Hello")
        .banner(data: .constant(Notification(title: "Welcome!", detail: "Have fun finding what you like!", type: .Success)), show: .constant(true))
    }
  }
}

