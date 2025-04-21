import SwiftUI
import PhotosUI

struct EditView: View {
    @State private var piece: Piece
    @State private var pickerItem: PhotosPickerItem?
    @State private var displayedImage: Image?
    @State private var scaleFactorX: CGFloat = 1
    @State private var scaleFactorY: CGFloat = 1
    
    init(piece: Piece, pickerItem: PhotosPickerItem? = nil, displayedImage: Image? = nil) {
        self.piece = piece
        self.pickerItem = pickerItem
        self.displayedImage = displayedImage
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                
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
                    ScrollView() {
                        VStack {
                            HStack {
                                Spacer(minLength: 0)
                                InfoCell(displayedInfo: "Underwear ", width: 160, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                    .onTapGesture {
                                        editPopUp(changing: "Type of Clothing", dictionary: Dictionaries.typesEncode)
                                    }
                                InfoCell(displayedInfo: "Over-the-Knee", width: 210, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                Spacer(minLength: 0)
                            }
                            HStack {
                                Spacer(minLength: 0)
                                InfoCell(displayedInfo: "Polyester", width: 140, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                InfoCell(displayedInfo: "Unkown", width: 130, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                InfoCell(displayedInfo: "XXXS", width: 90, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                Spacer(minLength: 0)
                            }
                            HStack {
                                Spacer(minLength: 0)
                                InfoCell(displayedInfo: "Anthropologie", width: 200, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                ColorPreviewBox(color: piece.getSwiftColor(), width: 168, height: 50, cornerRadius: 15)
                                Spacer(minLength: 0)
                            }
                            HStack {
                                Spacer(minLength: 0)
                                InfoCell(displayedInfo: piece.owner, width: 375, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                Spacer(minLength: 0)
                            }
                            HStack {
                                Spacer(minLength: 0)
                                InfoCell(displayedInfo: piece.uniqueID, width: 375, height: 100, cornerRadius: 15, scaleFactorX: 0.9, scaleFactorY: 0.9)
                                Spacer(minLength: 0)
                            }
                        }
                        .frame(width: geometry.size.width)
                        .fixedSize()
                    }
                }
            }
        }
    }
    
//    var owner: String
//    var uniqueID: String
}



