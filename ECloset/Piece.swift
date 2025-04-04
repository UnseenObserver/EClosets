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
    var size: String
    var image: Data?
    var colorR: Int
    var colorG: Int
    var colorB: Int
    var brand: String
    var owner: String
    var season: Int
    var uniqueID: String
    
    init(name: String, fit: String, type: String, size: String, image: Data? = nil, colorR: Int, colorG: Int, colorB: Int, brand: String, owner: String, season: Int, uniqueID: String) {
        self.name = name
        self.fit = fit
        self.type = type
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
    
    func getSwiftColor(red: Double, green: Double, blue: Double) -> Color {
        var foundColor: Color
        foundColor = Color(red: red, green: green, blue: blue)
        return foundColor
    }
    
    func getFitCode(fitS: String) -> String {
        var fitC: String = ""
        return fitC
    }
    
    func getTypeCode(typeS: String) -> String {
        var fitC: String = ""
        return fitC
    }
    
    func getSizeCode(sizeS: String) -> Int {
        var sizeC = 0
        return sizeC
    }
    
    func getBrandCode(brandS: String) -> String {
        var fitC: String = ""
        return fitC
    }
    
    func getSeasonCode(seasonS: Int) -> Int {
        var seasonC = 0
        return seasonC
    }
    
    
    
}
