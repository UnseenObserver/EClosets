//
//  ColorPreviewBox.swift
//  ECloset
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUICore
import SwiftUI

struct ColorPreviewBox: View {
    let color: Color
    @State var width: CGFloat
    @State var height: CGFloat
    @State var cornerRadius: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(width: width, height: height)
            .shadow(radius: cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.gray.opacity(0.5), lineWidth: 1))
    }
}
