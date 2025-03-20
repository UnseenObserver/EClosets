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
            HStack(alignment: .top, spacing: 0.0) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .padding(.leading, 5)

                VStack(alignment: .trailing) {
                    Text("WWWWWWWWWWWW")
                        .font(.body)
                        .fontWeight(.bold)
                        .lineLimit(1)

                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Fit:        ").font(.callout)
                            Text("Type:").font(.callout)
                            Text("Size:").font(.callout)
                        }
                        

                        // 🎨 Color Box with Tap Tracking
                        ColorBox(color: color, showPopup: $showPopup, tapLocation: $tapLocation, popupPosition: $popupPosition)
                    }
                    
                }
            }
            .frame(height: 140)
            
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

// ✅ Color Box That Triggers Pop-Up
struct ColorBox: View {
    let color: Color
    @Binding var showPopup: Bool
    @Binding var tapLocation: CGPoint
    @Binding var popupPosition: VerticalAlignment
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(color)
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .shadow(radius: 5)
                .onTapGesture {
                    withAnimation {
                        let boxFrame = geometry.frame(in: .global)
                        tapLocation = CGPoint(x: boxFrame.midX, y: boxFrame.midY)
                        popupPosition = tapLocation.y > screenHeight / 2 ? .top : .bottom
                        showPopup.toggle()
                    }
                }
        }
        .frame(width: 120, height: 120) // Fixes Layout Issues
    }
}

// ✅ Floating Color Info Popup
struct ColorInfoPopup: View {
    let color: Color
    let position: VerticalAlignment

    var body: some View {
        VStack(spacing: 0) {
            if position == .bottom { Triangle().fill(Color.white).frame(width: 30, height: 15).offset(y: 1) }

            VStack {
                Text("Color Details").font(.headline).padding(.bottom, 5)
                Text(getColorInfo(color)).font(.caption).padding().multilineTextAlignment(.center)
                Divider()
                HStack {
                    ColorPreviewBox(color: color)
                    Text("Tap to Copy").font(.footnote).foregroundColor(.gray)
                }
                .padding(.top, 5)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.90)).shadow(radius: 5))
            .frame(width: 200)

            if position == .top { Triangle().fill(Color.white).frame(width: 30, height: 15).offset(y: -1) }
        }
    }

    // 🏷️ Get Hex & RGB Values
    func getColorInfo(_ color: Color) -> String {
        let uiColor = UIColor(color)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let hex = String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
        return "Hex: \(hex)\nRGB: (\(Int(red * 255)), \(Int(green * 255)), \(Int(blue * 255)))"
    }
}

// 🎨 Small Color Preview Box
struct ColorPreviewBox: View {
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(color)
            .frame(width: 40, height: 40)
            .shadow(radius: 2)
            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray.opacity(0.5), lineWidth: 1))
    }
}

// 🔺 Triangle Shape for Pop-Up Tail
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    ContentView()
}
