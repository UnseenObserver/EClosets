//
//  ClosetCell.swift
//  EClosets
//
//  Created by Charlotte Pawloski on 3/21/25.

import SwiftUI
import SwiftData

/// The Primary view for seeing the users profile and stats of the closet
struct ProfileView: View {
    @Query private var pieces: [Piece]
    
    /// Calculate the total number of items to display on the profile tab
    var totalItems: Int {
        pieces.count
    }
    
    /// Calculates the number of pieces by the different types of clothing
    var itemsByType: [String: Int] {
        Dictionary(grouping: pieces, by: { $0.type })
            .mapValues { $0.count }
    }
    
    /// Calculates the number of pieces owner by different owners
    var itemsByOwner: [String: Int] {
        Dictionary(grouping: pieces, by: { $0.owner })
            .mapValues { $0.count }
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Statistics") {
                    HStack {
                        Text("Total Items")
                        Spacer()
                        Text("\(totalItems)")
                            .foregroundStyle(.secondary)
                    }
                }
                
                Section("Items by Type") {
                    ForEach(itemsByType.keys.sorted(), id: \.self) { type in
                        HStack {
                            Text(type)
                            Spacer()
                            Text("\(itemsByType[type, default: 0])")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                
                Section("Items by Owner") {
                    ForEach(itemsByOwner.keys.sorted(), id: \.self) { owner in
                        HStack {
                            Text(owner)
                            Spacer()
                            Text("\(itemsByOwner[owner, default: 0])")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}
