//
//  ContentView.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 29/03/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  // MARK: Fetching data
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default
  ) private var items: FetchedResults<Item>
  
  // MARK: - Body
  var body: some View {
    NavigationView {
      List {
        ForEach(items) { item in
          Text("Item at \(item.timestamp!, formatter: itemFormatter)")
        }
        .onDelete(perform: deleteItems)
      } // :List
      .toolbar {
        #if os(iOS)
        ToolbarItem(placement: .navigationBarLeading) {
          EditButton()
        }
        #endif
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: addItem) {
            Label("Add Item", systemImage: "plus")
          }
        }
      } // :Toolbar
    } // :NavigationView
  }
  
  // MARK: - Functions
  
  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
  
  private func deleteItems(offsets: IndexSet) {
    withAnimation {
      offsets.map { items[$0] }.forEach(viewContext.delete)
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
