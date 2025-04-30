//
//  ColorPreviewBox.swift
//  ECloset
//
//  Created by Charlotte Pawloski on 4/17/25.
//

import SwiftUICore
import SwiftUI

/// Reusable view to help display colors and who they belong to
struct ColorPreviewBox: View {
    ///T he color that should be displayed
    let color: Color
    /// The width of the box
    @State var width: CGFloat
    /// The height of the box
    @State var height: CGFloat
    /// The corner radius of the box
    @State var cornerRadius: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(color)
            .frame(width: width, height: height)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.primary.opacity(0.1), lineWidth: 1))
    }
}
