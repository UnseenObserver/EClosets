//
//  EClosetsApp.swift
//  EClosets
//
//  Created by HPro2 on 3/17/25.
//

import SwiftUI

@main
struct EClosetsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
