//
//  CreateView.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import SwiftUI

struct CreateView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var todoModel: TodoObservable
    
    var body: some View {
        List {
            TextField("Title", text: $todoModel.todo.title)
            DatePicker("Choose a date", selection: $todoModel.todo.timestamp)
            Toggle("Important?", isOn: $todoModel.todo.isCritical)
            Button("Create") {
                do {
                    try todoModel.save()
                    dismiss()
                } catch {
                    print(error)
                }
            }
        }.navigationTitle("Add Task")
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        let preview = TodoProvider.shared
        CreateView(todoModel: .init(provider: preview))
            .environment(\.managedObjectContext, preview.viewContext)
    }
}
