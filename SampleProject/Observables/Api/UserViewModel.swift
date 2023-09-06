//
//  UserViewModel.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 6/9/23.
//

import Foundation

final class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    
    func fetchUsers() {
        
        let usersUrlString = "https://jsonplaceholder.typicode.com/users"
        if let url = URL(string: usersUrlString) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    
                } else {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    if let data = data, let users = try? decoder.decode([User].self, from: data) {
                        self.users = users
                    } else {
                        //TODO: Error
                    }
                }
            }.resume()
        }
    }
}
