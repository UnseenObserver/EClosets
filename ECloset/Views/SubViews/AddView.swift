//
//  AddView.swift
//  ECloset
//
//  Created by Student on 4/23/25.
//

import SwiftUI
import PhotosUI

struct AddView: View {
    @ObservedObject var piece: Piece = Piece()
    
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
                            .onTapGesture {
                                nameAlertShowing = true
                            }
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
                                            if piece.type != "Type" {
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
                                    .overlay(
                                        ColorPicker("", selection: $selectedColor, supportsOpacity: false)
                                            .labelsHidden()
                                            .opacity(0.015)
                                    )
                                    .frame(width: 168, height: 50)
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
            .presentationDetents([.fraction(0.473)])         // half-height
            .presentationDragIndicator(.visible)           // show the grab handle
        }
        .alert("Type Must Have Value", isPresented: $alertShowing) {
            
        }
        .textFieldAlert(
            isPresented: $nameAlertShowing,
                    title: "Enter something",
                    message: "This uses a UITextField!",
                    placeholder: "Type here...",
                    action: { input in
                        if let input = input {
                            piece.name = input
                        }
                    }
                )
        
        

    }
    
    func tapHandler(changingTitle: String, changingDictionary: [String:String]) {
        self.changingTitle = changingTitle
        self.changingDictionary = changingDictionary
        popupData = EditPopupData(title: changingTitle, dictionary: changingDictionary)
    }
    
//    var owner: String
//    var uniqueID: String
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



