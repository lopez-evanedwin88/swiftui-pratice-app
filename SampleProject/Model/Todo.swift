//
//  Todo.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import Foundation
import CoreData

final class Todo: NSManagedObject, Identifiable {
    
    @NSManaged var isCompleted: Bool
    @NSManaged var isCritical: Bool
    @NSManaged var timestamp: Date
    @NSManaged var title: String
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        
        setPrimitiveValue(false, forKey: "isCritical")
        setPrimitiveValue(false, forKey: "isCompleted")
        setPrimitiveValue(Date.now, forKey: "timestamp")
    }
}

extension Todo {
    
    private static var todoFetchRequest: NSFetchRequest<Todo> {
        NSFetchRequest(entityName: "Todo")
    }
    
    static func all() -> NSFetchRequest<Todo> {
        let request: NSFetchRequest<Todo> = todoFetchRequest
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Todo.title, ascending: true)
        ]
        
        return request
    }
}

extension Todo {
    
    @discardableResult
    static func makePreview(count: Int, context: NSManagedObjectContext) -> [Todo] {
        var todos = [Todo]()
        
        for i in 0..<count {
            let todo = Todo(context: context)
            
            todo.title = "item \(i)"
            todo.isCritical = Bool.random()
            todo.isCompleted = false
            todo.timestamp = Date.now
            
            todos.append(todo)
        }
        
        return todos
    }
    
    static func preview(context: NSManagedObjectContext = TodoProvider.shared.viewContext) -> Todo {
        return makePreview(count: 1, context: context)[0]
    }
    
    static func empty(context: NSManagedObjectContext = TodoProvider.shared.viewContext) -> Todo {
        return Todo(context: context)
    }
}
