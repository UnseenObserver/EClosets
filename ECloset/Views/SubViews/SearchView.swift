import SwiftUI
import SwiftData

struct SearchView: View {
    @Query private var pieces: [Piece]
    @State private var searchText = ""
    @State private var selectedFilters: [String: String] = [:]
    
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
            }
            .searchable(text: $searchText, prompt: "Search your closet")
            .navigationTitle("Search")
        }
    }
}
