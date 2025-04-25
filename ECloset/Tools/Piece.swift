//
//  Piece.swift
//  EClosets
//
//  Created by HPro2 on 4/1/25.
//

import Foundation
import SwiftData
import UIKit
import SwiftUI



@Model
class Piece: ObservableObject {
    var name: String
    var fit: String
    var type: String
    var material: String
    var size: String
    var image: Data?
    var colorR: Double
    var colorG: Double
    var colorB: Double
    var brand: String
    var owner: String
    var season: String
    var uniqueID: String
    
    init(name: String, fit: String, type: String, marterial: String, size: String, image: Data? = nil, colorR: Double, colorG: Double, colorB: Double, brand: String, owner: String, season: String, uniqueID: String) {
        self.name = name
        self.fit = fit
        self.type = type
        self.material = marterial
        self.size = size
        self.image = image
        self.colorR = colorR
        self.colorG = colorG
        self.colorB = colorB
        self.brand = brand
        self.owner = owner
        self.season = season
        self.uniqueID = uniqueID
    }
    
    init() {
        self.name = "Piece"
        self.fit = "Fit"
        self.type = "Type"
        self.material = "Material"
        self.size = "Size"
        self.image = UIImage(systemName: "person.fill")!.pngData()
        self.colorR = 255
        self.colorG = 255
        self.colorB = 255
        self.brand = "Brand"
        self.owner = "Owner"
        self.season = "Season"
        self.uniqueID = "###,###,###,##,WW,WW,WWW,#,WWW,WWWWWWWWWWWWWWWWWW"
    }
    
    

    func getSwiftColor() -> Color {
        var foundColor: Color
        foundColor = Color(red: colorR, green: colorG, blue: colorB)
        return foundColor
    }
    
    func getCGColor() -> CGColor {
        let red   = CGFloat(colorR) / 255.0
        let green = CGFloat(colorG) / 255.0
        let blue  = CGFloat(colorB) / 255.0
        
        return CGColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func getSeasonString() -> String {
        var seasonString: String
        switch season {
        case "1":
            seasonString = "Winter"
        case "2":
            seasonString = "Spring"
        case "3":
            seasonString = "Summer"
        case "4":
            seasonString = "Fall"
        default:
            seasonString = "Unknown"
        }
        
        return seasonString
    }
    
    func generateUniqueID(for piece: Piece) -> String {
        let red = Int(piece.colorR)
        let green = Int(piece.colorG)
        let blue = Int(piece.colorB)
        
        let typeCode = Dictionaries.typesEncode[piece.type] ?? "NA"
        let sizeCode = Dictionaries.sizesEncode[piece.size] ?? "NA"
        let fitDictionary = Dictionaries().getFitDictionary(piece: piece, flipped: false)
        let fitCode = fitDictionary[piece.fit] ?? "NA"
        let materialCode = Dictionaries.materialEncode[piece.material] ?? "NA"
        let seasonCode = Dictionaries.seasonEncode[piece.season] ?? "NA"
        let brandCode = Dictionaries.clothingBrandsEncode[piece.brand] ?? "NA"
        
        return String(format: "%03d,%03d,%03d,%@,%@,%@,%@,%@,%@,%@",
                     red, green, blue, sizeCode, typeCode, fitCode, materialCode, seasonCode, brandCode, piece.owner)
    }
    
}
