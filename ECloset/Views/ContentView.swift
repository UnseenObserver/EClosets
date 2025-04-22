import SwiftUI
import UIKit
import _PhotosUI_SwiftUI
import SwiftUICore

struct ContentView: View {
    @State private var showPopup = false
    @State private var popupPosition: VerticalAlignment = .top
    @State private var tapLocation: CGPoint = .zero
    @State var selectedTab = 0
    let color: Color = .blue
    let piece: Piece = Piece()
    
    
    var body: some View {
        ZStack {
            // 🏠 Main Tab View
            TabView {
                Tab("Closet", systemImage: "duffle.bag.fill") {
                    ClosetView(showPopup: $showPopup,tapLocation: $tapLocation,popupPosition: $popupPosition,color: color)
                }
                Tab("Search", systemImage: "magnifyingglass") {
                    SearchView()
                }
                Tab("Profile", systemImage: "person.fill") {
                    ProfileView()
                }
                Tab("Edit", systemImage: "pencil") {
                    EditView(piece: piece)
                }
                Tab("EditPop", systemImage: "pencil") {
                    editPopUp(piece: piece, changingTitle: "Changing", dictionary: Dictionaries.clothingBrandsEncode)
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
    ContentView()
}
