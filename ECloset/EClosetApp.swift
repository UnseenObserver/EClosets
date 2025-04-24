//
//  EClosetsApp.swift
//  EClosets
//
//  Created by HPro2 on 3/17/25.
//

import SwiftUI
import SwiftData

@main
struct EClosetApp: App {
    // Remove the CoreData persistence controller since you're using SwiftData
    // let persistenceController = PersistenceController.shared
    
    @State private var selectedTab: Int = 0

    var body: some Scene {
        WindowGroup {
            ContentView(selectedTab: $selectedTab)
                // Remove the CoreData environment
                // .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .modelContainer(for: Piece.self)
    }
}
