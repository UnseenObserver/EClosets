//
//  editPopUp.swift
//  ECloset
//
//  Created by HPro2 on 4/21/25.
//

import SwiftUICore
import SwiftUI

struct EditPopUp: View {
    @ObservedObject var piece: Piece
    let changingTitle: String
    var dictionary: [String:String]

    @State private var searchText: String = ""
    @Environment(\.dismiss) private var dismiss

    // 1. Compute a filtered list of keys
    private var filteredKeys: [String] {
        if changingTitle != "Sizes" {
            dictionary.keys
                .filter { key in
                    // If searchText is empty, include everything.
                    // Otherwise only keys containing the text (case‐insensitive).
                    searchText.isEmpty
                    ? true
                    : key.localizedCaseInsensitiveContains(searchText)
                }
                .sorted()
        } else {
            dictionary.values
                .filter { values in
                    // If searchText is empty, include everything.
                    // Otherwise only keys containing the text (case‐insensitive).
                    searchText.isEmpty
                    ? true
                    : values.localizedCaseInsensitiveContains(searchText)
                }
                .sorted()
        }
    }

    var body: some View {
        NavigationStack {
            if filteredKeys.isEmpty {
                List {
                    // 2. Show "no results" when appropriate
                    if filteredKeys.isEmpty {
                        Text("No \(changingTitle) found")
                            .foregroundColor(.secondary)
                    } else {
                        Text("Unkown")
                            .onTapGesture {
                                applyChange(for: "Unkown")
                                dismiss()
                            }
                        Section(changingTitle) {
                            ForEach(filteredKeys, id: \.self) { key in
                                if key == "Unknown" {
                                    
                                } else {
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
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search \(changingTitle)…"
                )
                .navigationTitle(changingTitle)
            }
        }
    }

    // Your existing mutation logic, renamed for clarity
    private func applyChange(for key: String) {
        switch changingTitle {
        case "Types":
            piece.type = key

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
            }

        default:
            break
        }
    }
    
    
}


struct EditPopupData: Identifiable {
    let id = UUID()
    let title: String
    let dictionary: [String:String]
}
