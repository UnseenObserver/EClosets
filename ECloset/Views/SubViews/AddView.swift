//
//  AddView.swift
//  ECloset
//
//  Created by Charlotte Pawloski on 4/23/25.
//

import SwiftUI
import PhotosUI
import SwiftData

/// The primary view for adding pieces
struct AddView: View {
    /// The context of the storage model
    @Environment(\.modelContext) private var modelContext
    /// Enviromental trait for automatic saving for the dismissing of the popover
    @Environment(\.dismiss) private var dismiss
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
    /// Transitional Piece Varable used to build the new piece before sending it to the modals storage context
    @State private var newPiece = Piece()
    /// Boolean uesed to present the camera view for picture taking
    @State private var isCameraPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        ZStack {
                            VStack() {
                                PhotosPicker(
                                    selection: $pickerItem,
                                    matching: .images,
                                    photoLibrary: .shared()
                                ) {
                                    
                                    Group {
                                        if let img = displayedImage {
                                            img
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
                                do {
                                    if let data = try await item.loadTransferable(type: Data.self),
                                       let ui = UIImage(data: data) {
                                        await MainActor.run {
                                            displayedImage = Image(uiImage: ui)
                                            newPiece.image = data
                                        }
                                    }
                                } catch {
                                    print("❌ Failed to load image data:", error)
                                }
                            }
                        }
                        .padding()
                        
                        Text(newPiece.name)
                            .font(.title)
                            .fontWeight(.heavy)
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                nameAlertShowing = true
                            }
                        ScrollView() {
                            VStack {
                                HStack {
                                    Spacer(minLength: 0)
                                    InfoCell(displayedInfo: newPiece.type, width: 160, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Types", changingDictionary: Dictionaries.typesEncode)
                                        }
                                    InfoCell(displayedInfo: newPiece.fit, width: 210, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            if newPiece.type != "Type" {
                                                tapHandler(changingTitle: "Fits", changingDictionary: Dictionaries().getFitDictionary(piece: newPiece, flipped: false))
                                            } else {
                                                alertShowing = true
                                            }
                                        }
                                    Spacer(minLength: 0)
                                }
                                HStack {
                                    Spacer(minLength: 0)
                                    InfoCell(displayedInfo: newPiece.material, width: 140, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Materials", changingDictionary: Dictionaries.materialEncode)
                                        }
                                    InfoCell(displayedInfo: newPiece.season, width: 130, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Seasons", changingDictionary: Dictionaries.seasonEncode)
                                        }
                                    InfoCell(displayedInfo: newPiece.size, width: 90, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Sizes", changingDictionary: Dictionaries.sizesEncode)
                                        }
                                    Spacer(minLength: 0)
                                }
                                HStack {
                                    Spacer(minLength: 0)
                                    InfoCell(displayedInfo: newPiece.brand, width: 200, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            tapHandler(changingTitle: "Brands", changingDictionary: Dictionaries.clothingBrandsEncode)
                                        }
                                    ColorPreviewBox(color: selectedColor, width: 168, height: 50, cornerRadius: 15)
                                        .onTapGesture{
                                            colorPickerShowing = true
                                        }
                                        .frame(width: 168, height: 50)
                                    Spacer(minLength: 0)
                                }
                                HStack {
                                    Spacer(minLength: 0)
                                    InfoCell(displayedInfo: newPiece.owner, width: 375, height: 50, cornerRadius: 15, scaleFactorX: scaleFactorX, scaleFactorY: scaleFactorY)
                                        .onTapGesture {
                                            ownerAlertShowing = true
                                        }
                                    Spacer(minLength: 0)
                                }
                                HStack {
                                    Spacer(minLength: 0)
                                    InfoCell(displayedInfo: newPiece.uniqueID, width: 375, height: 100, cornerRadius: 15, scaleFactorX: 0.9, scaleFactorY: 0.9)
                                    Spacer(minLength: 0)
                                }
                            }
                            .frame(width: geometry.size.width)
                            .fixedSize()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        newPiece.uniqueID = Piece().generateUniqueID(for: newPiece)
                        
                        modelContext.insert(newPiece)
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
        }
        .sheet(item: $popupData) { data in
            EditPopUp(piece: newPiece,
                      changingTitle: data.title,
                      dictionary: data.dictionary)
            .presentationDetents([.fraction(0.473)])
            .presentationDragIndicator(.visible)
        }
        .alert("Type Must Have Value", isPresented: $alertShowing) {
            
        }
        .sheet(isPresented: $colorPickerShowing) {
            ColorPickerPopUp(title: "Color of Piece", selectedColor: selectedColor) { color in
                selectedColor = color
                let uiColor = UIColor(selectedColor)
                var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                
                newPiece.colorR = Double(red * 255)
                newPiece.colorG = Double(green * 255)
                newPiece.colorB = Double(blue * 255)
                
                colorPickerShowing = false
            }
            .padding(.top, 8)
            .background(.background)
            .interactiveDismissDisabled(false)
            .presentationDetents([.fraction(0.57), .height(640)])
        }
        .sheet(isPresented: $isCameraPresented) {
            CameraView { data in
                newPiece.image = data
            }
        }
        .textFieldAlert(
            isPresented: $nameAlertShowing,
            title: "Name",
            message: "The Name of the Piece",
            placeholder: "Name",
            action: { input in
                if let input = input {
                    newPiece.name = input
                }
            }
        )
        .textFieldAlert(
            isPresented: $ownerAlertShowing,
            title: "Owner",
            message: "The Owner of this Piece",
            placeholder: "Owner",
            action: { input in
                if let input = input {
                    newPiece.owner = input
                }
            }
        )
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
}

///Extention to allow for an alert for the name and owner variables of the piece
extension View {
    /// Custom Alert with textfeild
    /// - Parameters:
    ///   - isPresented: Binded Boolean to determine if the view is presented or not
    ///   - title: The title of the alert
    ///   - message: The message of the alert
    ///   - placeholder: The placeholder text in the text feild
    ///   - action: The function or exection of the view with the string recived
    /// - Returns: the variable returned
    func textFieldAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        placeholder: String = "",
        action: @escaping (String?) -> Void
    ) -> some View {
        background(
            TextFieldAlertModifier(
                isPresented: isPresented,
                title: title,
                message: message,
                placeholder: placeholder,
                action: action
            )
        )
    }
}




