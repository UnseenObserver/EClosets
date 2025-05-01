//
//  ClosetCell.swift
//  EClosets
//
//  Created by Charlotte Pawloski on 3/21/25.

import SwiftUI
import PhotosUI
import SwiftData

/// The primary view for editiing pieces
struct EditView: View {
    /// The context of the storage model
    @Environment(\.modelContext) private var modelContext
    /// Enviromental trait for automatic saving for the dismissing of the popover
    @Environment(\.dismiss) private var dismiss
    /// The recieved Piece from the init
    @State var piece: Piece
    
    /// The adapting item that has been picked inside the photopicker
    @State private var pickerItem: PhotosPickerItem?
    /// Image data variable that is used to take the image from the photopicker before sending the data to the piece.image
    @State private var displayedImage: Image?
    /// Scope scale factor for the X axis CGFloat that is sent to the infoCells for acurate and constant formating
    @State private var scaleFactorX: CGFloat = 1
    /// Scope scale factor for the Y axis CGFloat that is sent to the infoCells for acurate and constant formating
    @State private var scaleFactorY: CGFloat = 1
    /// String variable that is sent to the the editPopUp. I is the determining variable to which the different fit dictionaries, and the text around the pop up
    @State private var changingTitle: String = "Type Of Cloths"
    /// Dictionary variable that is sent to the editPopUp. It is used to determine the dictionary that the data is taken from
    @State private var changingDictionary: [String:String] = Dictionaries.typesEncode
    /// Transitional Variable that is used to hold all the sent data to the editPopUp for easy data managment
    @State private var popupData: EditPopupData?
    /// The color that is selected in the colorPreviewBox before it is set to the piece.color's
    @State private var selectedColor: Color = .white
    /// Boolean used to present the warning to the user that piece.type must have a value before selecting a fit in the editView. This is due to the type if clothing being the determining factor of the sent dictionary for the editPopUp
    @State private var alertShowing: Bool = false
    /// Boolean used to present the colorPickerPopUp
    @State private var colorPickerShowing: Bool = false
    /// Boolean used to present the nameAlertPopUp
    @State private var nameAlertShowing: Bool = false
    /// Boolean used to present the ownerAlertPopUp
    @State private var ownerAlertShowing: Bool = false
    /// Boolean uesed to present the cameraView
    @State private var isCameraPresented = false
    

    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        ZStack {
                            PhotosPicker(
                                selection: $pickerItem,
                                matching: .images,
                                photoLibrary: .shared()
                            ) {
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
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                
                                .frame(maxWidth: .infinity)
                                .frame(height: geometry.size.width)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                
                            }
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    Button(action: {
                                        isCameraPresented = true
                                    }) {
                                        Image(systemName: "camera")
                                            .padding(12)
                                            .background(Color.white.opacity(0.8))
                                            .clipShape(Circle())
                                            .shadow(radius: 4)
                                    }
                                    .padding(.trailing, 16)
                                    .padding(.bottom, 16)
                                }
                            }
                        }
                        .onChange(of: pickerItem) { oldItem, newItem in
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
                                    InfoCell(piece: piece, displayedInfo: "Types", width: 160, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Types", changingDictionary: Dictionaries.typesEncode)
                                        }
                                    InfoCell(piece: piece, displayedInfo: "Fits", width: 210, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            if piece.type != "Type" {
                                                if piece.type != "Unknown" {
                                                    tapHandler(changingTitle: "Fits", changingDictionary: Dictionaries().getFitDictionary(piece: piece, flipped: false))
                                                } else {
                                                    alertShowing = true
                                                }
                                            } else {
                                                alertShowing = true
                                            }
                                        }
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    InfoCell(piece: piece, displayedInfo: "Materials", width: 140, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Materials", changingDictionary: Dictionaries.materialEncode)
                                        }
                                    InfoCell(piece: piece, displayedInfo: "Seasons", width: 130, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Seasons", changingDictionary: Dictionaries.seasonEncode)
                                        }
                                    InfoCell(piece: piece, displayedInfo: "Sizes", width: 90, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Sizes", changingDictionary: Dictionaries.sizesEncode)
                                        }
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    InfoCell(piece: piece, displayedInfo: "Brands", width: 200, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
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
                                    InfoCell(piece: piece, displayedInfo: piece.owner, width: 375, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            ownerAlertShowing = true
                                        }
                                    Spacer()
                                }
                                
                                HStack {
                                    Spacer()
                                    InfoCell(piece: piece, displayedInfo: piece.uniqueID, width: 375, height: 100, cornerRadius: 15, scaleFactorX: 0.9, scaleFactorY: 0.9)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                if let data = piece.image, let uiImage = UIImage(data: data) {
                    displayedImage = Image(uiImage: uiImage)
                }
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
            .sheet(isPresented: $isCameraPresented) {
                CameraView { data in
                    piece.image = data
                               }
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
                                            
        }
    }
    
    /// used in the .onTapGesture for the infoCell, with its main funcition consolidating and verifiy the data being sent to the infoCell
    /// - Parameters:
    ///   - changingTitle: The string variable that corilates with the thing being changed so that the editPopUp can be used for any variable
    ///   - changingDictionary: The dictionary varibale that is sent to display all the data from the global dictionaries of information
    func tapHandler(changingTitle: String, changingDictionary: [String:String]) {
        self.changingTitle = changingTitle
        self.changingDictionary = changingDictionary
        popupData = EditPopupData(title: changingTitle, dictionary: changingDictionary)
    }
    
    /// Helper function for making the image variables play nicely allowing for greater ease
    /// - Parameter uiImage: The UIImage Value of the image
    func pictureHelper(uiImage: UIImage) {
        displayedImage = Image(uiImage: uiImage)
    }
}
