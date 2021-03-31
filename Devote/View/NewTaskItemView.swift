//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Víctor Manuel Puga Ruiz on 30/03/21.
//

import SwiftUI

struct NewTaskItemView: View {
  // MARK: - Properties
  @Environment(\.managedObjectContext) private var viewContext

  @Binding var isShowing: Bool
  
  @State private var task: String = ""
  
  private var isButtonDisabled: Bool { task.isEmpty }
  
  // MARK: - Body
  var body: some View {
    VStack {
      Spacer()
      VStack(spacing: 16) {
        TextField("New Task", text: $task)
          .foregroundColor(.pink)
          .font(.system(size: 24, weight: .bold, design: .rounded))
          .padding()
          .background(Color(.systemGray6))
          .cornerRadius(10)
        
        Button(action: {
          addItem()
        }) {
          Spacer()
          Text("SAVE")
            .font(.system(size: 24, weight: .bold, design: .rounded))
          Spacer()
        }
        .disabled(isButtonDisabled)
        .padding()
        .foregroundColor(.white)
        .background(isButtonDisabled ? Color.blue: Color.pink )
        .cornerRadius(10)
      } // :VStack
      .padding(.horizontal)
      .padding(.vertical, 20)
      .background(Color.white)
      .cornerRadius(16)
      .shadow(color: Color.black.opacity(0.65), radius: 24)
      .frame(maxWidth: 640)
    } // :VStack
    .padding()
  }
  
  // MARK: - Functions
  
  private func addItem() {
    withAnimation {
      let newItem = Item(context: viewContext)
      newItem.timestamp = Date()
      newItem.task = task
      newItem.completion = false
      newItem.id = UUID()
      
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
      
      task = ""
      hideKeyboard()
      isShowing = false
    }
  }
}

// MARK: - Preview
struct NewTaskItemView_Previews: PreviewProvider {
  static var previews: some View {
    NewTaskItemView(isShowing: .constant(true))
      .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
      .background(Color.gray.edgesIgnoringSafeArea(.all))
  }
}
