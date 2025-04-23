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
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(color)
                .frame(width: 40, height: 40)
                .cornerRadius(10)
        }
        .frame(width: 40, height: 40)
    }
}
