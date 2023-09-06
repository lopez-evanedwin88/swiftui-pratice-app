//
//  TodoRowView.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import SwiftUI

struct TodoRowView: View {
    
    let provider: TodoProvider
    @ObservedObject var todo: Todo
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8) {
                if todo.isCritical {
                    Image(systemName: "exclamationmark.3")
                        .symbolVariant(.fill)
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .bold()
                }
                Text(todo.title).font(.largeTitle).bold()
                
                Text("\(todo.timestamp, format: Date.FormatStyle(date:.numeric, time: .shortened) )").font(.callout)
            }
            Spacer()
            Button {
                toggleCompleted()
            } label: {
                Image(systemName: "checkmark")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(todo.isCompleted ? .green : .gray)
                    .font(.largeTitle)
            }
            .buttonStyle(.plain)
        }
    }
}

private extension TodoRowView {
    
    func toggleCompleted() {
        todo.isCompleted.toggle()
        do {
            try provider.persist(in: provider.viewContext)
        } catch {
            print(error)
        }
    }
}

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        let previewProvider = TodoProvider.shared
        TodoRowView(provider: previewProvider, todo: .preview(context: previewProvider.viewContext))
    }
}
