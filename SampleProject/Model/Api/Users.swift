//
//  Users.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 6/9/23.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let company: Company
}

struct Company: Codable {
    let name: String
}
