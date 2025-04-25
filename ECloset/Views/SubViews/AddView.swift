//
//  AddView.swift
//  ECloset
//
//  Created by Student on 4/23/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // Create a new piece for adding to database
    @State private var newPiece = Piece()
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var displayedImage: Image?
    @State private var scaleFactorX: CGFloat = 1
    @State private var scaleFactorY: CGFloat = 1
    @State private var isPresented: Bool = false
    @State private var changingTitle: String = "Type Of Cloths"
    @State private var changingDictionary: [String:String] = Dictionaries.typesEncode
    @State private var popupData: EditPopupData?
    @State private var selectedColor: Color = Color.white
    @State private var alertShowing: Bool = false
    @State private var nameAlertShowing: Bool = false
    @State private var ownerAlertShowing: Bool = false
    @State private var colorPickerShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    VStack {
                        
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
                .interactiveDismissDisabled(true)
                .presentationDetents([.height(640)])
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
    }
    
    func tapHandler(changingTitle: String, changingDictionary: [String:String]) {
        self.changingTitle = changingTitle
        self.changingDictionary = changingDictionary
        popupData = EditPopupData(title: changingTitle, dictionary: changingDictionary)
    }
    
   
}

extension View {
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




