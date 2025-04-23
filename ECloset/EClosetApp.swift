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
    let persistenceController = PersistenceController.shared
    @State private var selectedTab: Int = 0

    var body: some Scene {
        WindowGroup {
            ContentView(selectedTab: $selectedTab)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .modelContainer(for: Piece.self)
    }
}
