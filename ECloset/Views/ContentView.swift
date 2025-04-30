//
//  ClosetCell.swift
//  EClosets
//
//  Created by Charlotte Pawloski on 3/21/25.

import SwiftUI
import UIKit
import _PhotosUI_SwiftUI
import SwiftUICore

/// The main view, containg the tabview that is the top most level interaction.
struct ContentView: View {
    /// The tab the is activly showing. Updates automatically and can be used to switch or see when the user is.
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                Tab("Closet", systemImage: "duffle.bag.fill", value: 0) {
                    ClosetView()
                }
                Tab("Search", systemImage: "magnifyingglass", value: 1) {
                    SearchView()
                }
                Tab("Profile", systemImage: "person.fill", value: 2) {
                    ProfileView()
                }
            }
        }
    }
}

#Preview {
    StatefulPreviewWrapper(0) { selectedTab in
        ContentView(selectedTab: selectedTab)
    }
}

/// To send an @State value to the preview to allow for more efficent testing
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    private var content: (Binding<Value>) -> Content

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
