import SwiftUI
import UIKit
import _PhotosUI_SwiftUI
import SwiftUICore

struct ContentView: View {
    @Binding var selectedTab: Int
    let color: Color = .blue
    let piece: Piece = Piece()
    
    
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
                Tab("edit", systemImage: "pencil", value: 3) {
                    EditView(piece: piece)
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
