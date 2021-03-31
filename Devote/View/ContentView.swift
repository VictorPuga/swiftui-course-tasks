//
//  ContentView.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 29/03/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  // MARK: - Properties
  @Environment(\.managedObjectContext) private var viewContext
  
  @State private var showNewTaskItem: Bool = false
  
  // MARK: Fetching data
  @FetchRequest(
    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    animation: .default
  ) private var items: FetchedResults<Item>
  
  // MARK: - Body
  var body: some View {
    NavigationView {
      ZStack {
        // MARK: Main view
        VStack {
          // MARK: Header
          Spacer(minLength: 80)
          
          // MARK: New task button
          Button(action: {
            showNewTaskItem = true
          }) {
            Image(systemName: "plus.circle")
              .font(.system(size: 30, weight: .semibold, design: .rounded))
            Text("New Task")
              .font(.system(size: 24, weight: .bold, design: .rounded))
          }
          .foregroundColor(.white)
          .padding(.horizontal, 20)
          .padding(.vertical, 15)
          .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing))
          .clipShape(Capsule())
          .shadow(color: Color.black.opacity(0.25), radius: 9, x: 0, y: 4)
          // MARK: - Tasks
          List {
            ForEach(items) { item in
              VStack(alignment: .leading) {
                Text(item.task ?? "")
                  .font(.headline)
                  .fontWeight(.bold)
                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                  .font(.footnote)
                  .foregroundColor(.gray)
              } // :List item
            }
            .onDelete(perform: deleteItems)
          } // :List
          .listStyle(InsetGroupedListStyle())
          .shadow(color: Color.black.opacity(0.3), radius: 12)
          .padding(.vertical, 0)
          .frame(maxWidth: 640)
        } // :VStack
        // MARK: - New taask item
        if showNewTaskItem {
          BlankView()
            .onTapGesture {
              withAnimation {
                showNewTaskItem = false
              }
            }
          NewTaskItemView(isShowing: $showNewTaskItem)
        }
      } // :ZStack
      .onAppear {
        UITableView.appearance().backgroundColor = .clear
      }
      .navigationBarTitle("Daily Tasks", displayMode: .large)
      .toolbar {
        #if os(iOS)
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        #endif
      } // :Toolbar
      .background(BackgroundImageView())
      .background(
        backgroundGradient.ignoresSafeArea(.all)
      )
    } // :NavigationView
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
  // MARK: - Functions
  
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
