//
//  UpdateView.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import SwiftUI

struct UpdateView: View {
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var todo: Todo

    var body: some View {
        List {
            TextField("Title", text: $todo.title)
            DatePicker("Choose a date", selection: $todo.timestamp)
            Toggle("Important?", isOn: $todo.isCritical)
            Button("Update") {
                do {
                    try moc.save()
                    dismiss()
                } catch {
                    print(error)
                }
            }
        }.navigationTitle("Update Task")
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView(todo: .preview())
    }
}
