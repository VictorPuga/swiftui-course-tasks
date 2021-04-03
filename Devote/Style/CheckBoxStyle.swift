//
//  CheckBoxStyle.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 03/04/21.
//

import SwiftUI

struct CheckBoxStyle: ToggleStyle {
  // MARK: - makeBody
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
        .foregroundColor(configuration.isOn ? .pink : .primary)
        .font(.system(size: 30, weight: .semibold, design: .rounded))
        .onTapGesture {
          configuration.isOn.toggle()
          feedback.notificationOccurred(.success)
          
          if configuration.isOn {
            playSound(sound: "sound-rise", type: "mp3")
          } else {
            playSound(sound: "sound-tap", type: "mp3")
          }
        }
      configuration.label
    } // :HStack
  }
}

// MARK: - Preview
struct CheckBoxStyle_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Toggle("Label", isOn: .constant(true))
      Toggle("Label", isOn: .constant(false))
    }
    .toggleStyle(CheckBoxStyle())
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
