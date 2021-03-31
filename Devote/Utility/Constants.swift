//
//  Constants.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 29/03/21.
//

import SwiftUI

// MARK: Formatter

let itemFormatter: DateFormatter = {
  let formatter = DateFormatter()
  formatter.dateStyle = .short
  formatter.timeStyle = .medium
  return formatter
}()

// MARK: UI

var backgroundGradient: LinearGradient {
  LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

// MARK: UX
