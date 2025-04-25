import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var pieces: [Piece]
    
    var totalItems: Int {
        pieces.count
    }
    
    var itemsByType: [String: Int] {
        Dictionary(grouping: pieces, by: { $0.type })
            .mapValues { $0.count }
    }
    
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
