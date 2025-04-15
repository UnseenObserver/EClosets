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
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(piece.name).font(.title).fontWeight(.heavy).multilineTextAlignment(.leading).lineLimit(1)
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
                        .frame(width: 200, height: 200)
                }
            }
        }
        Spacer()
    }
    
}
