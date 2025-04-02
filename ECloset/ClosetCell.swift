//
//  ClosetCell.swift
//  EClosets
//
//  Created by HPro2 on 3/21/25.

import SwiftUI


struct ClosetCell: View {
    @Binding var showPopup: Bool
    @Binding var tapLocation: CGPoint
    @Binding var popupPosition: VerticalAlignment
    let color: Color
    let piece: Piece
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(.trailing, 3)
                
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("WWWWWWWWWWWW")
                        .font(.body)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .frame(width: 210, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    HStack(alignment: .top, spacing: 0.0) {
                        VStack(alignment: .leading) {
                            Text("Fit:").font(.callout).lineLimit(1).padding(.bottom, 0.5)
                            Text("Type:").font(.callout).lineLimit(1).padding(.bottom, 0.5)
                            Text("Size:").font(.callout).lineLimit(1)
                        }
                        .frame(width: 165, alignment: .leading)
                        VStack(alignment: .trailing) {
                            Spacer()
                            ColorBox(color: color, showPopup: $showPopup, tapLocation: $tapLocation, popupPosition: $popupPosition)
                                .padding(0)
                        }
                        .frame(height: 115)
                    }
                    
                }
                
            }
            .padding( .vertical, 2).padding(.horizontal, 5)
        }
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
                .frame(width: 40, height: 40)
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
        .frame(width: 40, height: 40)
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
