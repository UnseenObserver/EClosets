//
//  ClosetCell.swift
//  EClosets
//
//  Created by HPro2 on 3/21/25.

import SwiftUI
import SwiftData

/// Primary view for searching the stored pieces
struct SearchView: View {
    /// Array of all stored pieces
    @Query private var pieces: [Piece]
    /// Input variable for search bar
    @State private var searchText = ""
    /// Selected filter for search display
    @State private var selectedFilters: [String: String] = [:]
    private var alexIsDumb: String = "Yes"
    
    /// Variable responsible for filter the pieces based on the different types of information
    var filteredPieces: [Piece] {
        if searchText.isEmpty && selectedFilters.isEmpty {
            return pieces
        }
        
        return pieces.filter { piece in
            let matchesSearch = searchText.isEmpty ||
            piece.name.localizedCaseInsensitiveContains(searchText) ||
            piece.brand.localizedCaseInsensitiveContains(searchText) ||
            piece.type.localizedCaseInsensitiveContains(searchText)
            
            let matchesFilters = selectedFilters.isEmpty || selectedFilters.allSatisfy { key, value in
                switch key {
                case "type": return piece.type == value
                case "fit": return piece.fit == value
                case "season": return piece.season == value
                case "size": return piece.size == value
                case "brand": return piece.brand == value
                default: return true
                }
            }
            
            return matchesSearch && matchesFilters
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if filteredPieces.isEmpty {
                        ContentUnavailableView("No matching items",
                                               systemImage: "magnifyingglass",
                                               description: Text("Try adjusting your search or filters"))
                    } else {
                        ForEach(filteredPieces) { piece in
                            ClosetCell(color: piece.getSwiftColor(), piece: piece)
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search your closet")
                
            }
            
        }
    }
}
