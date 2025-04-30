//
//  InfoCell.swift
//  ECloset
//
//  Created by Charlotte Pawloski on 4/15/25.
//

import SwiftUICore
import SwiftUI

/// Reuseable view meet to be an extremely
struct InfoCell: View {
    /// The string that should be displayed
    @State var displayedInfo: String
    /// The width of the cell
    var width: CGFloat
    /// The height of the cell
    var height: CGFloat
    /// The radius of the corners of the cell
    var cornerRadius: CGFloat
    /// The 0-1 Scale factor of the x axis of the text (Not its frame)
    var scaleFactorX: CGFloat
    /// The 0-1 Scale factor of the y axis of the text (Not its frame)
    var scaleFactorY: CGFloat
    
    
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
