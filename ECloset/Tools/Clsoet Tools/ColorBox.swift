//
//  ColorBox.swift
//  ECloset
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUICore
import SwiftUI
import UIKit

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
                .onTapGesture {
                    withAnimation {
                        let boxFrame = geometry.frame(in: .global)
                        tapLocation = CGPoint(x: boxFrame.midX, y: boxFrame.midY)
                        popupPosition = tapLocation.y > screenHeight / 2 ? .top : .bottom
                        showPopup.toggle()
                    }
                    print("HI!")
                }
        }
        .frame(width: 40, height: 40)
    }
}
