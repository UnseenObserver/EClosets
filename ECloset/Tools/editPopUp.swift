//
//  editPopUp.swift
//  ECloset
//
//  Created by HPro2 on 4/21/25.
//

import SwiftUICore
import SwiftUI

struct editPopUp: View {
    let piece: Piece
    @State var changingTitle: String
    @State var dictionary: [String:String]
    
    var body: some View {
        VStack {
            HStack {
                
                Text(changingTitle)
                    .font(.title3)
                Spacer()
                Button("Done") {
                    
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
                List(dictionary.keys.sorted(), id: \.self) { key in
                    Text(key)
                        .onTapGesture {
                            switch changingTitle {
                            case "Type Of Cloths":
                                piece.type = Dictionaries.typesDecode[key]!
                            case "Fit Of Cloths":
                                switch piece.type {
                                case "SHIRT":
                                    piece.fit = Dictionaries.shirtFitsDecode[key]!
                                case "PANTS":
                                    piece.fit = Dictionaries.pantsFitsDecode[key]!
                                case "DRESS":
                                    piece.fit = Dictionaries.dressFitsDecode[key]!
                                case "SKIRT":
                                    piece.fit = Dictionaries.skirtFitsDecode[key]!
                                case "COAT":
                                    piece.fit = Dictionaries.coatFitsDecode[key]!
                                case "SHORTS":
                                    piece.fit = Dictionaries.shortsFitsDecode[key]!
                                case "UNDERWEAR":
                                    piece.fit = Dictionaries.underwearFitsDecode[key]!
                                case "SOCK":
                                    piece.fit = Dictionaries.sockFitsDecode[key]!
                                case "BRA":
                                    piece.fit = Dictionaries.braFitsDecode[key]!
                                default:
                                    piece.fit = "ER"
                                }
                            case "Size Of Cloths":
                                piece.size = Dictionaries.sizesDecode[key]!
                            case "Material Made Of" :
                                piece.material = Dictionaries.materialDecode[key]!
                            case "Brand":
                                piece.brand = Dictionaries.clothingBrandsDecode[key]!
                            case "Season To Wear":
                                piece.season = Int(Dictionaries.seasonDecode[key]!)!
                            default:
                                Text("Error")
                            }
                        }
                }
            
        }
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.90)).shadow(radius: 5))
    }
}
