import SwiftUI
import PhotosUI

struct EditView: View {
    @State private var piece: Piece
    @State private var pickerItem: PhotosPickerItem?
    @State private var displayedImage: Image?
    
    init(piece: Piece, pickerItem: PhotosPickerItem? = nil, displayedImage: Image? = nil) {
        self.piece = piece
        self.pickerItem = pickerItem
        self.displayedImage = displayedImage
    }

    var body: some View {
        GeometryReader { geometry in
            VStack() {
                PhotosPicker(
                    selection: $pickerItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    // Your “button” label
                    Group {
                        if let img = displayedImage {
                            img
                                .resizable()
                                .scaledToFill()
                        } else {
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: geometry.size.width)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .onChange(of: pickerItem) { oldItem, newItem in
                    guard let item = newItem else { return }
                    Task {
                        do {
                            // Load as Data (Transferable)
                            if let data = try await item.loadTransferable(type: Data.self),
                               let ui = UIImage(data: data) {
                                // Back on the main thread, update your SwiftUI Image
                                await MainActor.run {
                                    displayedImage = Image(uiImage: ui)
                                }
                            }
                        } catch {
                            print("❌ Failed to load image data:", error)
                        }
                    }
                }
                
                .padding()
                
                Text(piece.name)
                    .font(.title)
                    .fontWeight(.heavy)
                    .frame(maxWidth: .infinity)
                
                HStack {
                    InfoCell(displayedInfo: piece.size, width: 100, height: 75, cornerRadius: 15, spaceAroundX: 10, spaceAroundY: 10)
                    Spacer()
                    InfoCell(displayedInfo: piece.type, width: 175, height: 75, cornerRadius: 15, spaceAroundX: 10, spaceAroundY: 10)
                    Spacer()
                    ColorPreviewBox(color: piece.getSwiftColor(), width: 75, height: 75, cornerRadius: 15)
                    Spacer()
                }
                .padding(10)
            }
        }
    }
    
    
//    var fit: String
//
//    var material: String
//
//
//    var colorR: Int
//    var colorG: Int
//    var colorB: Int
//    var brand: String
//    var owner: String
//    var season: Int
//    var uniqueID: String
}



