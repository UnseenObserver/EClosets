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
    @State var piece: Piece
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
                
                Text(stringFinder(changingTitle: displayedInfo))
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
    
    ///Applys the changes of the users interaction with the view to the data of the piece
    private func stringFinder(changingTitle: String) -> String{
        var placeHolderString: String = ""
        
        switch changingTitle {
        case "Types":
            placeHolderString = piece.type
        case "Fits":
                placeHolderString = piece.fit
        case "Sizes":
                placeHolderString = piece.size
        case "Materials":
                placeHolderString = piece.material
        case "Brands":
                placeHolderString = piece.brand
        case "Seasons":
                placeHolderString = piece.season
            
        case "Owner":
            placeHolderString = piece.owner
        default:
            break
        }
        
        return placeHolderString
    }
}
