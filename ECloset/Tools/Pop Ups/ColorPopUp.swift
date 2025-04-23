//
//  ColorPopUp.swift
//  ECloset
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUICore
import SwiftUI

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
                    ColorPreviewBox(color: color, width: 40, height: 40, cornerRadius: 5)
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
