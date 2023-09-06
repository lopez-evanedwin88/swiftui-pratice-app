//
//  TodoRowView.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import SwiftUI

struct ATodoRowView: View {
    
    let todo: ATodo
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8) {
                Text(todo.title).font(.largeTitle).bold()
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "checkmark")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(todo.completed ? .green : .gray)
                    .font(.largeTitle)
            }
            .buttonStyle(.plain)
        }
    }
}

struct ATodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        ATodoRowView(todo: .init(userId: 0, id: 1, title: "Code", completed: false))
    }
}
