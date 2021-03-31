//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 30/03/21.
//

import SwiftUI

#if canImport(UIKit)
extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
#endif
