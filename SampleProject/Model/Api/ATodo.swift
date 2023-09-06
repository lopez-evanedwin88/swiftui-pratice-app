//
//  ATodo.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 6/9/23.
//

import Foundation

struct ATodo: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
