import SwiftData
import SwiftUICore
import SwiftUI
import _SwiftData_SwiftUI

struct ClosetView: View {
    @State private var isPresentedEditView: Bool = false
    @State private var isPresentedAddView: Bool = false
    @State private var selectedPiece: Piece?
    
    // Query to fetch all pieces
    @Query private var pieces: [Piece]
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 10)
                Button() {
                    // Sort functionality could be added here
                } label: {
                    Label("Sort", systemImage: "line.horizontal.3.decrease.circle")
                }
                .disabled(true)
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
                List {
                    ForEach(pieces) { piece in
                        ClosetCell(color: piece.getSwiftColor(), piece: piece)
                            .frame(width: 360)
                            .padding(0)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button() {
                                    selectedPiece = piece
                                    isPresentedEditView = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.accentColor)
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
                    .onDelete(perform: deletePieces)
                }
                .contentMargins(10)
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
    }
    
    // Function to delete pieces
    func deletePieces(at offsets: IndexSet) {
        @Environment(\.modelContext) var modelContext
        
        for index in offsets {
            modelContext.delete(pieces[index])
        }
        
        try? modelContext.save()
    }
}
