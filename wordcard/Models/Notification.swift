//
//  Notification.swift
//  wordcard
//
//  Created by Фёдор Ткаченко on 03.01.23.
//

import Foundation
import SwiftUI

enum NotificationType {
  case Info
  case Warning
  case Success
  case Error
  
  var tintColor: Color {
    switch self {
    case .Info:
      return Color(red: 0, green: 0, blue: 0)
    case .Success:
      return Color.green
    case .Warning:
      return Color.yellow
    case .Error:
      return Color.red
    }
  }
}


struct Notification {
  var title: LocalizedStringKey
  var detail: LocalizedStringKey
  var type: NotificationType
}
