//
//  ListRowItemView.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 03/04/21.
//

import SwiftUI

struct ListRowItemView: View {
  // MARK: - Properties
  @Environment(\.managedObjectContext) var viewContext
  
  @ObservedObject var item: Item
  
  // MARK: - Body
  var body: some View {
    Toggle(isOn: $item.completion) {
      Text(item.task ?? "")
        .font(.system(.title2, design: .rounded))
        .fontWeight(.heavy)
        .foregroundColor(item.completion ? .pink : .primary)
        .padding(.vertical, 12)
        .animation(.default)
    } // :Toggle
    .toggleStyle(CheckBoxStyle())
    .onReceive(item.objectWillChange, perform: { _ in
      if viewContext.hasChanges {
        try? viewContext.save()
      }
    })
  }
}
