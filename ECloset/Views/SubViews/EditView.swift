import SwiftUI
import PhotosUI

struct EditView: View {
    @ObservedObject var piece: Piece
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var displayedImage: Image?
    @State private var scaleFactorX: CGFloat = 1
    @State private var scaleFactorY: CGFloat = 1
    @State private var isPresented: Bool = false
    @State private var changingTitle: String = "Type Of Cloths"
    @State private var changingDictionary: [String:String] = Dictionaries.typesEncode
    @State private var popupData: EditPopupData?
    @State private var selectedColor: Color
    @State private var alertShowing: Bool = false
    @State var colorPickerShowing: Bool = false
    
    init(piece: Piece, pickerItem: PhotosPickerItem? = nil, displayedImage: Image? = nil) {
        self.piece = piece
        self.pickerItem = pickerItem
        self.displayedImage = displayedImage
        _selectedColor = State(initialValue: piece.getSwiftColor())
    }

    var body: some View {
        VStack {
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
                                        .scaledToFit()
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
                                    InfoCell(displayedInfo: piece.type, width: 160, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Types", changingDictionary: Dictionaries.typesEncode)
                                        }
                                    InfoCell(displayedInfo: piece.fit, width: 210, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            if piece.type != "" {
                                                tapHandler(changingTitle: "Fits", changingDictionary: Dictionaries().getFitDictionary(piece: piece, flipped: false))
                                            } else {
                                                alertShowing = true
                                            }
                                                      }
                                    Spacer(minLength: 0)
                                }
                                HStack {
                                    Spacer(minLength: 0)
                                    InfoCell(displayedInfo: piece.material, width: 140, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Materials", changingDictionary: Dictionaries.materialEncode)
                                        }
                                    InfoCell(displayedInfo: piece.season, width: 130, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Seasons", changingDictionary: Dictionaries.seasonEncode)
                                        }
                                    InfoCell(displayedInfo: piece.size, width: 90, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Sizes", changingDictionary: Dictionaries.sizesEncode)
                                        }
                                    Spacer(minLength: 0)
                                }
                                HStack {
                                    Spacer(minLength: 0)
                                    InfoCell(displayedInfo: piece.brand, width: 200, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Brands", changingDictionary: Dictionaries.clothingBrandsEncode)
                                        }
                                    ColorPreviewBox(color: selectedColor, width: 168, height: 50, cornerRadius: 15)
                                        .onTapGesture {
                                            colorPickerShowing = true
                                        }
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
        .sheet(item: $popupData) { data in
          EditPopUp(piece: piece,
                    changingTitle: data.title,
                    dictionary: data.dictionary)
          .presentationDetents([.fraction(0.473),.large])         // half-height
            .presentationDragIndicator(.visible)           // show the grab handle
        }
        .sheet(isPresented: $colorPickerShowing, content: {
            ColorPickerPopUp(title: "Color of Piece", selectedColor: selectedColor, didSelectColor: { color in
                self.selectedColor = color
                self.colorPickerShowing = false
            })
                .padding(.top, 8)
                .background(.background)
                .interactiveDismissDisabled(true)
                .presentationDetents([.height(640)])
        })
        .alert("Type Must Have Value", isPresented: $alertShowing) {
            
        }
        

    }
    
    func tapHandler(changingTitle: String, changingDictionary: [String:String]) {
        self.changingTitle = changingTitle
        self.changingDictionary = changingDictionary
        popupData = EditPopupData(title: changingTitle, dictionary: changingDictionary)
    }
    
//    var owner: String
//    var uniqueID: String
}



