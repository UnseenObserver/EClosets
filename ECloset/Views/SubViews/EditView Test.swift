//
//  EditView Test.swift
//  ECloset
//
//  Created by HPro2 on 4/17/25.
//

import SwiftUI
import PhotosUI

struct EditViewTest: View {
    var piece: Piece
    @State private var imageItem: PhotosPickerItem?
    @State private var imageData: Data?
    
    init(piece: Piece) {
        self.piece = piece
        self.imageItem = nil
        self.imageData = piece.image
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // 1) Photo picker behaves like a button
            PhotosPicker(
                selection: $imageItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Group {
                    if let data = imageData,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        // default placeholder until tapped
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(width: 200, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            // remove inline style → this will now present as a sheet on tap
            
            // 2) react to selection and load data
            .onChange(of: imageItem) { newItem in
                Task {
                    if let data = try? await newItem?.loadTransferable(type: Data.self) {
                        imageData = data
                    }
                }
            }
            
            // other content
            Text(piece.name)
                .font(.title).fontWeight(.heavy)
            
            HStack(spacing: 20) {
                InfoCell(displayedInfo: piece.size,
                         width: 100, height: 75,
                         cornerRadius: 15,
                         spaceAroundX: 10, spaceAroundY: 10)
                InfoCell(displayedInfo: piece.type,
                         width: 100, height: 75,
                         cornerRadius: 15,
                         spaceAroundX: 10, spaceAroundY: 10)
            }
        }
        .padding()
    }
}
