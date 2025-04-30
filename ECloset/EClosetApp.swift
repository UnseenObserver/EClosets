// EClosetApp.swift

import SwiftUI
import SwiftData

@main
struct EClosetApp: App {
    var body: some Scene {
        WindowGroup {
            StatefulPreviewWrapper(0) { selectedTab in
                ContentView(selectedTab: selectedTab)
            }
        }
        .modelContainer(for: Piece.self)
    }
}
