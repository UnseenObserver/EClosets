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
    var image: UIImage
    var color: Color
    var brand: String
    var owner: String
    var season: String
    var uniqueID: String
    
    init(name: String, fit: String, type: String, size: String, image: UIImage, color: Color, brand: String, owner: String, season: String, uniqueID: String) {
        self.name = name
        self.fit = fit
        self.type = type
        self.size = size
        self.image = image
        self.color = color
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
        self.image = UIImage(systemName: "person.fill")!
        self.color = Color(red: 1, green: 1, blue: 1,opacity: 1)
        self.brand = "Brand"
        self.owner = "Owner"
        self.season = "Season"
        self.uniqueID = "###,###,###,##,WW,WW,WWW,#,WWW,WWWWWWWWWWWWWWWWWW"
    }
    
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    func getName() -> String {
        
    }
    
}
