import SwiftUI
import UIKit
import _PhotosUI_SwiftUI
import SwiftUICore

struct ContentView: View {
    @Binding var selectedTab: Int
    
    @State private var showPopup = false
    @State private var popupPosition: VerticalAlignment = .top
    @State private var tapLocation: CGPoint = .zero
    let color: Color = .blue
    let piece: Piece = Piece()
    
    
    var body: some View {
        ZStack {
            // 🏠 Main Tab View
            TabView(selection: $selectedTab) {
                Tab("Closet", systemImage: "duffle.bag.fill", value: 0) {
                    ClosetView(showPopup: $showPopup,tapLocation: $tapLocation,popupPosition: $popupPosition,color: color)
                }
                Tab("Search", systemImage: "magnifyingglass", value: 1) {
                    SearchView()
                }
                Tab("Profile", systemImage: "person.fill", value: 2) {
                    ProfileView()
                }
                Tab("Edit", systemImage: "pencil", value: 3) {
                    EditView(piece: piece)
                }
                Tab("AddView", systemImage: "pencil", value: 4) {
                    AddView()
                }
            }
            // 🎨 Popup Renders ABOVE Everything Else
            if showPopup {
                ColorInfoPopup(color: color, position: popupPosition)
                    .position(x: tapLocation.x, y: popupPosition == .top ? tapLocation.y - 100 : tapLocation.y + 100)
                    .transition(.opacity)
                    .zIndex(1) // Ensures pop-up is always on top
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
