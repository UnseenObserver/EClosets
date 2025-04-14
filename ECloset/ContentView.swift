import SwiftUI
import _PhotosUI_SwiftUI

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
    
    // 📌 ClosetView With Embedded Color Box
struct ClosetView: View {
    @Binding var showPopup: Bool
    @Binding var tapLocation: CGPoint
    @Binding var popupPosition: VerticalAlignment
    let color: Color
    let screenHeight = UIScreen.main.bounds.height
    let piece: Piece = Piece()
    
    
    var body: some View {
        VStack {
            List {
                ClosetCell(showPopup: $showPopup, tapLocation: $tapLocation, popupPosition: $popupPosition, color: color, piece: piece)
                    .frame(width: 360)
                    .padding(0)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button() {
                            
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.accentColor)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            
                        } label: {
                            Label("Favorite", systemImage: "star")
                        }
                        .tint(.indigo)
                    }
                
            }
            .contentMargins(10)
        }
    }
    
    func newPiece() {
        print("HI")
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
    
struct EditView: View {
    var piece: Piece
    @State private var image: PhotosPickerItem?
    @State var imageData: Data?
    
    init(piece: Piece) {
        self.piece = piece
        self.image = nil
        self.imageData = piece.image!
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(piece.name).font(.title).fontWeight(.heavy).multilineTextAlignment(.leading).lineLimit(1)
                HStack {
                    PhotosPicker(
                        selection: $image,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Group {
                                if let imageData,
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                } else {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                        }
                        .frame(width: 200, height: 200)
                }
            }
        }
        Spacer()
    }
    
}

    
    
    


