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
    @State var spaceAroundX: CGFloat
    @State var spaceAroundY: CGFloat
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack {
                Rectangle()
                    .frame(width: width, height: height)
                    .foregroundStyle(.infoBackground)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius) )
                
                Text(displayedInfo)
                    .font(.largeTitle)
                    .zIndex(1)
                    .foregroundStyle(.primary)
                    .scaleEffect(x: 1 - ((spaceAroundX * 2) / 100), y: 1 - ((spaceAroundY * 2) / 100))
                    .frame(width: width, height: height)
                
            }
        }
        .frame(width: width, height: height)
    }
    
    
}
