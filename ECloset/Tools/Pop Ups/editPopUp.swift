//
//  editPopUp.swift
//  ECloset
//
//  Created by Charlotte Pawloski on 4/21/25.
//

import SwiftUICore
import SwiftUI


/// Reusable pop up for displaying the dictionaries of the value being edited of the item
struct EditPopUp: View {
    /// The piece which is being edited
    @State var piece: Piece
    /// The context of the storage model
    @Environment(\.modelContext) private var modelContext
    /// The title of the thing being changed. Used for data processing and for UI so must be correct to Dictionary
    let changingTitle: String
    /// The dictionary equivelent with the thing that must be changed
    var dictionary: [String:String]

    /// The text that has been inputed by the user in the search bar
    @State private var searchText: String = ""
    /// Global dismiss variable for when the view is dismissed
    @Environment(\.dismiss) private var dismiss

    /// Values out of the given dictionay filtered buy the inputed search text
    private var filteredKeys: [String] {
            dictionary.keys
                .filter { key in
                    searchText.isEmpty
                    ? true
                    : key.localizedCaseInsensitiveContains(searchText)
                }
                .sorted()
    }

    var body: some View {
        NavigationStack {
            List {
                if filteredKeys.isEmpty {
                    Text("No \(changingTitle) found")
                        .foregroundColor(.secondary)
                } else {
                    if changingTitle != "Sizes" {
                        Text("Unknown")
                            .onTapGesture {
                                applyChange(for: "Unknown")
                                dismiss()
                            }
                        Section("\(changingTitle)") {
                            ForEach(filteredKeys, id: \.self) { key in
                                if key != "Unknown" {
                                    Text(key)
                                        .onTapGesture {
                                            applyChange(for: key)
                                            try? modelContext.save()
                                            dismiss()
                                        }
                                }
                            }
                        }
                    } else {
                        Text("Unknown")
                            .onTapGesture {
                                applyChange(for: "Unknown")
                                dismiss()
                            }
                        Section("\(changingTitle)") {
                            ForEach(sizeDictionaryForEdit(), id: \.self) { key in
                                if key != "Unknown" {
                                    Text(key)
                                        .onTapGesture {
                                            applyChange(for: key)
                                            dismiss()
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search \(changingTitle)…"
            )
            .navigationTitle(changingTitle)
        }
    }

    ///Applys the changes of the users interaction with the view to the data of the piece
    private func applyChange(for key: String) {
        switch changingTitle {
        case "Types":
            piece.type = key
            try? modelContext.save()

        case "Fits":
            let forward = Dictionaries().getFitDictionary(piece: piece, flipped: false)
            let backward = Dictionaries().getFitDictionary(piece: piece, flipped: true)
            if let code = forward[key], let mapped = backward[code] {
                piece.fit = mapped
            }

        case "Sizes":
            if let code = Dictionaries.sizesEncode[key],
               let decoded = Dictionaries.sizesDecode[code] {
                piece.size = decoded
            }

        case "Materials":
            if let code = Dictionaries.materialEncode[key],
               let decoded = Dictionaries.materialDecode[code] {
                piece.material = decoded
            }

        case "Brands":
            if let code = Dictionaries.clothingBrandsEncode[key],
               let decoded = Dictionaries.clothingBrandsDecode[code] {
                piece.brand = decoded
            }

        case "Seasons":
            if let code = Dictionaries.seasonEncode[key],
               let decoded = Dictionaries.seasonDecode[code] {
                piece.season = decoded
                try? modelContext.save()
            }

        default:
            break
        }
        
        
    }

    //Todo- Make this progromatically change with the dictioanry\
    /// Get the correctly sorted dictionary for display for the size dictionary
    func sizeDictionaryForEdit() -> [String] {
        var tempArray: [String] = [""]
        
        tempArray = ["XXS", "XS", "S", "M", "L", "XL", "XXL", "3XL", "4XL", "5XL"]
        
        return tempArray
    }
}

///Data variable for easier transfer and packageing of varables
struct EditPopupData: Identifiable {
    let id = UUID()
    let title: String
    let dictionary: [String:String]
}
