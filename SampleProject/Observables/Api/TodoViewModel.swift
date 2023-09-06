//
//  UserViewModel.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 6/9/23.
//

import Foundation

final class TodoViewModel: ObservableObject {
    
    @Published var todos: [ATodo] = []
    
    //Simple approach
    func fetchTodos() {
        
        let todosUrlString = "https://jsonplaceholder.typicode.com/todos"
        if let url = URL(string: todosUrlString) {
            
            DispatchQueue.main.async {
                URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    if error != nil {
                        
                    } else {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        if let data = data, let users = try? decoder.decode([ATodo].self, from: data) {
                            self?.todos = users
                        } else {
                            //TODO: Error
                        }
                    }
                }.resume()
            }
        }
    }
    
    //Reference Link: https://medium.com/@dinerdapps/making-api-calls-with-async-await-in-swiftui-d924d8814ef0
    
    func fetchTodosViaModifier() async throws -> [ATodo] {
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([ATodo].self, from: data)
    }
}
