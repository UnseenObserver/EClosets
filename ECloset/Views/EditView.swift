//
//  EditView.swift
//  ECloset
//
//  Created by HPro2 on 4/15/25.
//

import SwiftUICore
import _PhotosUI_SwiftUI

struct EditView: View {
    var piece: Piece
    @State private var image: PhotosPickerItem?
    @State var imageData: Data?
    
    init(piece: Piece) {
        self.piece = piece
        self.image = nil
        self.imageData = piece.image!
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    PhotosPicker(
                        selection: $image,
                        matching: .images,
                        photoLibrary: .shared()) {
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
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width)
                }
                Text("WWWWWWWWWWWW")
                    .font(.title)
                    .fontWeight(.heavy)
                    .frame(width: geometry.size.width)
                HStack {
                    InfoCell(displayedInfo: "hi", width: 100, height: 100)
                }
            }
        }
    }
    
    func yes() {
        var fit: String
        var type: String
        var material: String
        var size: String
        var colorR: Int
        var colorG: Int
        var colorB: Int
        var brand: String
        var owner: String
        var season: Int
        var uniqueID: String
    }
}
