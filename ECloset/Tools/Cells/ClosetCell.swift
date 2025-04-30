//
//  ClosetCell.swift
//  EClosets
//
//  Created by Charlotte Pawloski on 3/21/25.

import SwiftUI
import PhotosUI


/// Custom View used as cells in the main closet List. Used to display all nessary information along with be the interatcation gate way to editing and deleteing the piece.
struct ClosetCell: View {
    /// The color being displayed in the colorPreiviewBox present on the closetCell
    let color: Color
    /// The Piece thats information is to be displayed
    let piece: Piece
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Group {
                    if let imageData = piece.image,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .scaledToFit()
                    } else {
                        Image(systemName: "tshirt")
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(width: 140, height: 140, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(piece.name)
                        .font(.body)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                        .frame(width: 210, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    HStack(alignment: .top, spacing: 0.0) {
                        VStack(alignment: .leading) {
                            Text("Fit: \(piece.fit)").font(.callout).lineLimit(1).padding(.bottom, 0.5)
                            Text("Type: \(piece.type)").font(.callout).lineLimit(1).padding(.bottom, 0.5)
                            Text("Size: \(piece.size)").font(.callout).lineLimit(1)
                        }
                        .frame(width: 165, alignment: .leading)
                        VStack(alignment: .trailing) {
                            Spacer()
                            ColorPreviewBox(color: color, width: 40, height: 40, cornerRadius: 12)
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
