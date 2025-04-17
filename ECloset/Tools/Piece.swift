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
class Piece {
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
    var season: Int
    var uniqueID: String
    
    init(name: String, fit: String, type: String, marterial: String, size: String, image: Data? = nil, colorR: Double, colorG: Double, colorB: Double, brand: String, owner: String, season: Int, uniqueID: String) {
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
        self.season = 1
        self.uniqueID = "###,###,###,##,WW,WW,WWW,#,WWW,WWWWWWWWWWWWWWWWWW"
    }
    
    

    func getSwiftColor() -> Color {
        var foundColor: Color
        foundColor = Color(red: colorR, green: colorG, blue: colorB)
        return foundColor
    }
    
    func getID(red: Int, green: Int, blue: Int, size: Int, type: String, fit: String, material: String, season: Int, brand: String, owner: String) {
        
        
    }
    
    
    
}
