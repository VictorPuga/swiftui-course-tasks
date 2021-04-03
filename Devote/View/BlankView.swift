//
//  BlankView.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 30/03/21.
//

import SwiftUI

struct BlankView: View {
  // MARK: - Properties
  var backgroundColor: Color
  var backgroundOpacity: Double
  
  // MARK: - Body
  var body: some View {
    VStack {
      Spacer()
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    .background(backgroundColor)
    .opacity(backgroundOpacity)
    .blendMode(.overlay)
    .edgesIgnoringSafeArea(.all)
  }
}

// MARK: - Preview
struct BlankView_Previews: PreviewProvider {
  static var previews: some View {
    BlankView(
      backgroundColor: .black,
      backgroundOpacity: 0.3
    )
      .background(BackgroundImageView())
      .background(backgroundGradient.ignoresSafeArea(.all))
  }
}
