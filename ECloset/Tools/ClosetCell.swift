//
//  ClosetCell.swift
//  EClosets
//
//  Created by HPro2 on 3/21/25.

import SwiftUI
import PhotosUI

struct ClosetCell: View {
    @Binding var showPopup: Bool
    @Binding var tapLocation: CGPoint
    @Binding var popupPosition: VerticalAlignment
    @State private var image: PhotosPickerItem?
    @State var imageData: Data?
    let color: Color
    let piece: Piece
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Group {
                    if let imageData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 140, height: 140, alignment: .center)
                
                
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
