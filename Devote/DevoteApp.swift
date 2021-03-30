//
//  DevoteApp.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 29/03/21.
//

import SwiftUI

@main
struct DevoteApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
