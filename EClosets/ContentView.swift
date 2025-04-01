import SwiftUI

struct ContentView: View {
    @State private var showPopup = false
    @State private var popupPosition: VerticalAlignment = .top
    @State private var tapLocation: CGPoint = .zero
    let color: Color = .blue

    var body: some View {
        ZStack {
            // 🏠 Main Tab View
            TabView {
                ClosetView(showPopup: $showPopup, tapLocation: $tapLocation, popupPosition: $popupPosition, color: color)
                    .tabItem { Label("Closet", systemImage: "duffle.bag.fill") }
                
                SearchView()
                    .tabItem { Label("Search", systemImage: "magnifyingglass") }
                
                ProfileView()
                    .tabItem { Label("Profile", systemImage: "person.fill") }
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

// 📌 ClosetView With Embedded Color Box
struct ClosetView: View {
    @Binding var showPopup: Bool
    @Binding var tapLocation: CGPoint
    @Binding var popupPosition: VerticalAlignment
    let color: Color
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        List {
            ClosetCell(showPopup: $showPopup, tapLocation: $tapLocation, popupPosition: $popupPosition, color: color)
        }
        
    }
}

// 🔍 Search Tab
struct SearchView: View {
    var body: some View {
        Text("🔍 Search Page").font(.largeTitle).bold()
    }
}

// 👤 Profile Tab
struct ProfileView: View {
    var body: some View {
        Text("👤 Profile Page").font(.largeTitle).bold()
    }
}



#Preview {
    ContentView()
}
