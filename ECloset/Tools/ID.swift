//
//  ID.swift
//  ECloset
//
//  Created by HPro2 on 4/8/25.
//

import Foundation


class ID {
    var ids: [String] = ["Delete", "Delete"]
    var extras: [String] = ["Delete", "Delete"]
    
    func getID(red: Int, green: Int, blue: Int, size: Int, type: String, fit: String, material: String, season: Int, brand: String, owner: String) {
        
        
    }
    
    func buildIDDictionary(piece: Piece) -> (String, (String, String)) {
        var idDictionaryEntry: (String, (String, String)) = ("",("",""))
        var iD = piece.uniqueID
        var name = piece.name
        var image = piece.image
        var extras: [String]
        
        //Name Validation
        //Image Validation
        //ID Validation
        
        
        return idDictionaryEntry
    }
    
}
