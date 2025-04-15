//
//  ClosetView.swift
//  ECloset
//
//  Created by HPro2 on 4/15/25.
//

import SwiftUICore
import UIKit
import SwiftUI

struct ClosetView: View {
    @Binding var showPopup: Bool
    @Binding var tapLocation: CGPoint
    @Binding var popupPosition: VerticalAlignment
    let color: Color
    let screenHeight = UIScreen.main.bounds.height
    let piece: Piece = Piece()
    
    
    var body: some View {
        VStack {
            List {
                ClosetCell(showPopup: $showPopup, tapLocation: $tapLocation, popupPosition: $popupPosition, color: color, piece: piece)
                    .frame(width: 360)
                    .padding(0)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button() {
                            
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.accentColor)
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            
                        } label: {
                            Label("Favorite", systemImage: "star")
                        }
                        .tint(.indigo)
                    }
                
            }
            .contentMargins(10)
        }
    }
    
    func newPiece() {
        print("HI")
    }
}
