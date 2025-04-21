//
//  InfoCell.swift
//  ECloset
//
//  Created by HPro2 on 4/15/25.
//

import SwiftUICore
import SwiftUI

struct InfoCell: View {
    @State var displayedInfo: String
    @State var width: CGFloat
    @State var height: CGFloat
    @State var cornerRadius: CGFloat
    @State var scaleFactorX: CGFloat
    @State var scaleFactorY: CGFloat
    
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Rectangle()
                    .frame(width: width, height: height)
                    .foregroundStyle(.infoBackground)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius) )
                    .overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(Color.primary.opacity(0.1), lineWidth: 1))
                
                Text(displayedInfo)
                    .font(.title3)
                    .zIndex(1)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
                    .scaleEffect(x: scaleFactorX, y: scaleFactorY)
                    .frame(width: width, height: height)
                    .contentMargins(0)
                    .fixedSize(horizontal: false, vertical: false)
                
            }
        }
        .frame(width: width, height: height)
    
    }
    
    
}
