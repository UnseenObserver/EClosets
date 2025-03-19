//
//  ContentView.swift
//  EClosets
//
//  Created by HPro2 on 3/17/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            ClosetView()
                .tabItem {
                    Label("Closet", systemImage: "duffle.bag.fill")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}


struct ClosetView: View {
    @State private var showPopup = false
    @State private var popupPosition: VerticalAlignment = .top
    @State private var tapLocation: CGPoint = .zero
    let screenHeight = UIScreen.main.bounds.height
    let color: Color = .blue  // Change this to any color
    
    var body: some View {
        ZStack {
            List {
                HStack(alignment: .top, spacing: 0.0) {
                    Image(systemName: "person.fill")
                        .resizable(capInsets: EdgeInsets(), resizingMode: .stretch)
                        .padding(.all, 5.0)
                        .frame(width: 120.0, height: 120.0)
                    VStack(alignment: .leading) {
                        Text("WWWWWWWWWWWW")
                            .font(.body)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                            .frame(width: nil)
                        HStack(alignment: .top) {
                            VStack(alignment: .leading) {
                                Text("Fit:")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                Text("Type:")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                                Text("Size:")
                                    .font(.callout)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            .frame(width: 100.0)
                            ColorBox(color: color, showPopup: $showPopup, tapLocation: $tapLocation, popupPosition: $popupPosition)
                            
                            
                            
                            
                        }
                    }
                }
                .frame(height: 150.0)
               
            }
            if showPopup {
                ColorInfoPopup(color: color, position: popupPosition, tapLocation: tapLocation.x)
                    .position(x: tapLocation.x, y: popupPosition == .top ? tapLocation.y - 100 : tapLocation.y + 100)
                    .transition(.scale)
                    .zIndex(1) // Ensures it's on top of everything
            }
        }
        
    }
}

struct SearchView: View {
    var body: some View {
        Text("🔍 Search Page")
            .font(.largeTitle)
            .bold()
    }
}

struct ProfileView: View {
    var body: some View {
        Text("👤 Profile Page")
            .font(.largeTitle)
            .bold()
    }
}

struct ColorBox: View {
    let color: Color
    @Binding var showPopup: Bool
    @Binding var tapLocation: CGPoint
    @Binding var popupPosition: VerticalAlignment
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 120, height: 120)
            .cornerRadius(10)
            .shadow(radius: 5)
            .onTapGesture { location in
                withAnimation {
                    // Set the tapLocation when the box is tapped
                    tapLocation = location
                    showPopup.toggle()
                    popupPosition = tapLocation.y > screenHeight / 2 ? .top : .bottom
                }
            }
    }
}

struct ColorInfoPopup: View {
    let color: Color
    let position: VerticalAlignment
    let tapLocation: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            if position == .bottom {
                Triangle()
                    .fill(Color.white)
                    .frame(width: 30, height: 15)
                    .position(x: tapLocation, y: 1) // Align with the tap's x position
            }

            VStack {
                Text("Color Details")
                    .font(.headline)
                    .padding(.bottom, 5)

                Text(getColorInfo(color))
                    .font(.caption)
                    .padding()
                    .multilineTextAlignment(.center)

                Divider()

                HStack {
                    ColorPreviewBox(color: color)
                    Text("Tap to Copy")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))

            if position == .top {
                Triangle()
                    .fill(Color.white)
                    .frame(width: 30, height: 15)
                    .position(x: tapLocation, y: -1) // Align with the tap's x position
            }
        }
        .frame(width: 220)
    }

    // Function to Get Hex & RGB Values
    func getColorInfo(_ color: Color) -> String {
        let uiColor = UIColor(color)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let hex = String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
        return "Hex: \(hex)\nRGB: (\(Int(red * 255)), \(Int(green * 255)), \(Int(blue * 255)))"
    }
}

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

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Top center
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom right
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom left
        path.closeSubpath()
        return path
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
