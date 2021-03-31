//
//  Persistence.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 29/03/21.
//

import CoreData

struct PersistenceController {
  // MARK: - Persistent Controller
  static let shared = PersistenceController()
  
  
  // MARK: - Persistent Container
  let container: NSPersistentContainer
  
  
  // MARK: - Initializer
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Devote")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  // MARK: - Preview
  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    for i in 0..<5 {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = "Sample task \(i)"
      newItem.completion = false
      newItem.id = UUID()
    }
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
}
