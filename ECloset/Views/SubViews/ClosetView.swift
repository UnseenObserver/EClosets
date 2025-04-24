import SwiftData
import SwiftUICore
import SwiftUI
import _SwiftData_SwiftUI

struct ClosetView: View {
    @State private var isPresentedEditView: Bool = false
    @State private var isPresentedAddView: Bool = false
    @State private var selectedPiece: Piece?
    @State private var showDeleteAlert: Bool = false
    @State private var pieceToDelete: Piece?
    @State private var showSortOptions: Bool = false
    @State private var sortOption: SortOption = .name
    @State private var sortOrder: SortOrder = .ascending
    
    @Environment(\.modelContext) var modelContext
    
    // Sort options enum
    enum SortOption: String, CaseIterable, Identifiable {
      case name, type, color, brand, season
      var id: String { rawValue }
    }
    
    enum SortOrder: String, CaseIterable, Identifiable {
        case ascending = "Ascending"
        case descending = "Descending"
        
        var id: String { self.rawValue }
    }
    
    // Query to fetch all pieces
    @Query(sort: \Piece.name) private var pieces: [Piece]
    
    // Computed property for sorted pieces
    private var sortedPieces: [Piece] {
        switch sortOption {
        case .name:
            return pieces.sorted { piece1, piece2 in
                sortOrder == .ascending ?
                (piece1.name < piece2.name) :
                (piece1.name > piece2.name)
            }
        case .type:
            return pieces.sorted { piece1, piece2 in
                sortOrder == .ascending ?
                (piece1.type < piece2.type) :
                (piece1.type > piece2.type)
            }
        
        case .brand:
            return pieces.sorted { piece1, piece2 in
                let brand1 = piece1.brand ?? ""
                let brand2 = piece2.brand ?? ""
                return sortOrder == .ascending ? (brand1 < brand2) : (brand1 > brand2)
            }
        case .season:
            return pieces.sorted { piece1, piece2 in
                let season1 = piece1.season ?? ""
                let season2 = piece2.season ?? ""
                return sortOrder == .ascending ? (season1 < season2) : (season1 > season2)
            }
        default:
            return pieces
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 10)
                Button() {
                    showSortOptions = true
                } label: {
                    Label("Sort", systemImage: "line.horizontal.3.decrease.circle")
                }
                .disabled(pieces.isEmpty)
                Spacer()
                Button() {
                    isPresentedAddView = true
                } label: {
                    Label("Add",systemImage: "plus" )
                }
                Spacer(minLength: 10)
            }
            .padding(5)
            
            if pieces.isEmpty {
                ContentUnavailableView("Your Closet is Empty",
                                      systemImage: "tshirt",
                                      description: Text("Tap the + button to add clothing items"))
            } else {
                HStack {
                    Text("Sorted by: \(sortOption.rawValue) (\(sortOrder.rawValue))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Spacer()
                }
                .padding(.horizontal)
                
                List {
                    ForEach(sortedPieces) { piece in
                        ClosetCell(color: piece.getSwiftColor(), piece: piece)
                            .frame(width: 360)
                            .padding(0)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button() {
                                    selectedPiece = piece
                                    isPresentedEditView = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.accentColor)
                                
                                Button() {
                                    pieceToDelete = piece
                                    showDeleteAlert = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    // Favorite functionality could be added here
                                } label: {
                                    Label("Favorite", systemImage: "star")
                                }
                                .tint(.indigo)
                            }
                    }
                }
                .contentMargins(10)
                .alert("Delete Item", isPresented: $showDeleteAlert) {
                    Button("Cancel", role: .cancel) {}
                    Button("Delete", role: .destructive) {
                        if let pieceToDelete = pieceToDelete {
                            deleteSpecificPiece(pieceToDelete)
                        }
                    }
                } message: {
                    Text("Are you sure you want to delete this item?")
                }
            }
        }
        .sheet(isPresented: $isPresentedEditView) {
            if let selectedPiece = selectedPiece {
                EditView(piece: selectedPiece)
                    .presentationDetents([.large])
            }
        }
        .sheet(isPresented: $isPresentedAddView) {
            AddView()
                .presentationDetents([.fraction(1)])
        }
        .actionSheet(isPresented: $showSortOptions) {
            ActionSheet(
                title: Text("Sort By"),
                message: nil,
                buttons: [
                    .default(Text("Name")) {
                        sortOption = .name
                        updateSortOrder()
                    },
                    .default(Text("Type")) {
                        sortOption = .type
                        updateSortOrder()
                    },
                    .default(Text("Color")) {
                        sortOption = .color
                        updateSortOrder()
                    },
                    .default(Text("Brand")) {
                        sortOption = .brand
                        updateSortOrder()
                    },
                    .default(Text("Season")) {
                        sortOption = .season
                        updateSortOrder()
                    },
                    .default(Text("Toggle Order: \(sortOrder == .ascending ? "Descending" : "Ascending")")) {
                        sortOrder = sortOrder == .ascending ? .descending : .ascending
                    },
                    .cancel()
                ]
            )
        }
    }
    
    // Helper function to update sort order when switching sort options
    private func updateSortOrder() {
        // When switching to a new sort option, default to ascending
        sortOrder = .ascending
    }
    
    // Function to delete pieces by index offsets (original method)
    func deletePieces(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(pieces[index])
        }
        
        try? modelContext.save()
    }
    
    // Function to delete a specific piece
    func deleteSpecificPiece(_ piece: Piece) {
        modelContext.delete(piece)
        try? modelContext.save()
    }
}
