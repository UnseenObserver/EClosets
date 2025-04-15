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
    
    var body: some View {
        ZStack {
            GeometryReader{ geometry in
                Rectangle()
                    .frame(width: width, height: height)
                    .presentationCornerRadius(10)
                Text(displayedInfo)
                    .font(.largeTitle)
                    .scaledToFit()
                    .frame(width: width - width/4, height: height - height/4)
                    .zIndex(1)
                
            }
        }
    }
    
}
