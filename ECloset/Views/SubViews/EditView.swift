import SwiftUI
import PhotosUI
import SwiftData

struct EditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var piece: Piece
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var displayedImage: Image?
    @State private var scaleFactorX: CGFloat = 1
    @State private var scaleFactorY: CGFloat = 1
    @State private var isPresented: Bool = false
    @State private var changingTitle: String = "Type Of Cloths"
    @State private var changingDictionary: [String:String] = Dictionaries.typesEncode
    @State private var popupData: EditPopupData?
    @State private var selectedColor: Color = .white
    @State private var alertShowing: Bool = false
    @State private var colorPickerShowing: Bool = false
    @State private var nameAlertShowing: Bool = false
    @State private var ownerAlertShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        PhotosPicker(
                            selection: $pickerItem,
                            matching: .images,
                            photoLibrary: .shared()
                        ) {
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
                        .onChange(of: pickerItem) { newItem in
                            guard let item = newItem else { return }
                            Task {
                                if let data = try? await item.loadTransferable(type: Data.self),
                                   let ui = UIImage(data: data) {
                                    await MainActor.run {
                                        displayedImage = Image(uiImage: ui)
                                        piece.image = data
                                    }
                                }
                            }
                        }
                        .padding()
                        
                        Text(piece.name)
                            .font(.title)
                            .fontWeight(.heavy)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                nameAlertShowing = true
                            }
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                HStack {
                                    Spacer()
                                    InfoCell(displayedInfo: piece.type, width: 160, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Types", changingDictionary: Dictionaries.typesEncode)
                                        }
                                    InfoCell(displayedInfo: piece.fit, width: 210, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            if !piece.type.isEmpty {
                                                tapHandler(changingTitle: "Fits", changingDictionary: Dictionaries().getFitDictionary(piece: piece, flipped: false))
                                            } else {
                                                alertShowing = true
                                            }
                                        }
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
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
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    InfoCell(displayedInfo: piece.brand, width: 200, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Brands", changingDictionary: Dictionaries.clothingBrandsEncode)
                                        }
                                    ColorPreviewBox(color: selectedColor, width: 168, height: 50, cornerRadius: 15)
                                        .onTapGesture {
                                            colorPickerShowing = true
                                        }
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    InfoCell(displayedInfo: piece.owner, width: 375, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            ownerAlertShowing = true
                                        }
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    InfoCell(displayedInfo: piece.uniqueID, width: 375, height: 100, cornerRadius: 15, scaleFactorX: 0.9, scaleFactorY: 0.9)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                // Initialize displayed image
                if let data = piece.image, let uiImage = UIImage(data: data) {
                    displayedImage = Image(uiImage: uiImage)
                }
                // Initialize selected color
                selectedColor = piece.getSwiftColor()
            }
            .sheet(item: $popupData) { data in
                EditPopUp(piece: piece,
                          changingTitle: data.title,
                          dictionary: data.dictionary)
                .presentationDetents([.fraction(0.473), .large])
                .presentationDragIndicator(.visible)
            }
            .sheet(isPresented: $colorPickerShowing) {
                ColorPickerPopUp(title: "Color of Piece", selectedColor: selectedColor) { color in
                    selectedColor = color
                    let uiColor = UIColor(color)
                    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                    piece.colorR = Double(red * 255)
                    piece.colorG = Double(green * 255)
                    piece.colorB = Double(blue * 255)
                }
                .padding(.top, 8)
                .background(.background)
                .interactiveDismissDisabled(false)
                .presentationDetents([.fraction(0.57), .height(640)])
            }
            .alert("Type Must Have Value", isPresented: $alertShowing) {}
            .textFieldAlert(isPresented: $nameAlertShowing,
                           title: "Name",
                           message: "The Name of the Piece",
                           placeholder: "Name") { input in
                if let input = input {
                    piece.name = input
                }
            }
            .textFieldAlert(isPresented: $ownerAlertShowing,
                           title: "Owner",
                           message: "The Owner of this Piece",
                           placeholder: "Owner") { input in
                if let input = input {
                    piece.owner = input
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
        }
    }
    
    func tapHandler(changingTitle: String, changingDictionary: [String:String]) {
        self.changingTitle = changingTitle
        self.changingDictionary = changingDictionary
        popupData = EditPopupData(title: changingTitle, dictionary: changingDictionary)
    }
}
