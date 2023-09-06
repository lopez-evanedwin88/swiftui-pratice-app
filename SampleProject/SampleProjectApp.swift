//
//  SampleProjectApp.swift
//  SampleProject
//
//  Created by d&a-m-pro  on 5/9/23.
//

import SwiftUI

@main
struct SampleProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, TodoProvider.shared.viewContext)
        }
    }
}
