//
//  TodoObservable.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import Foundation
import CoreData

final class TodoObservable: ObservableObject {
    
    @Published var todo: Todo
    
    private let context: NSManagedObjectContext
    
    init(provider: TodoProvider, todo: Todo? = nil) {
        self.context = provider.newContext
        self.todo = Todo(context: self.context)
    }
    
    func save() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
