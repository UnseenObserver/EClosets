//
//  ID.swift
//  ECloset
//
//  Created by HPro2 on 4/8/25.
//

import Foundation
import SwiftUI

class ID {
    static let shared = ID()
    
    private var idDictionary: [String: (String, String)] = [:] // ID: (Name, ImageRef)
    
    private init() {}
    
    func getID(red: Int, green: Int, blue: Int, size: String, type: String, fit: String, material: String, season: String, brand: String, owner: String) -> String {
        // Format: "RRR,GGG,BBB,SS,TT,FF,MMM,S,BBB,OOOOOOOOOOOOOOOOOO"
        return String(format: "%03d,%03d,%03d,%@,%@,%@,%@,%@,%@,%@",
                     red, green, blue, size, type, fit, material, season, brand, owner)
    }
    
    func buildIDDictionary(piece: Piece) -> (String, (String, String)) {
        let iD = piece.uniqueID
        let name = piece.name
        let imageRef = UUID().uuidString
        let entry: (String, (String, String)) = (iD, (name, imageRef))
        
        // Basic validation
        guard !iD.isEmpty && !name.isEmpty else {
            return ("INVALID", ("INVALID", "INVALID"))
        }
        
        idDictionary[iD] = (name, imageRef)
        return entry
    }
    
    func getItemByID(_ id: String) -> (String, String)? {
        return idDictionary[id]
    }
    
    func updateItemName(_ id: String, newName: String) {
        if var item = idDictionary[id] {
            item.0 = newName
            idDictionary[id] = item
        }
    }
    
    func updateItemImageRef(_ id: String, newImageRef: String) {
        if var item = idDictionary[id] {
            item.1 = newImageRef
            idDictionary[id] = item
        }
    }
    
    func deleteItem(_ id: String) {
        idDictionary.removeValue(forKey: id)
    }
    
    func exportPieces() {
        //TODO
    }
}
