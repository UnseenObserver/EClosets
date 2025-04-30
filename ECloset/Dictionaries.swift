//
//  ClosetCell.swift
//  EClosets
//
//  Created by Charlotte Pawloski on 3/21/25.

import Foundation

extension Dictionary where Value: Hashable {
    /// Function to take in a dictionary anf flip the values and keys
    /// - Returns: New flipped dictionary
    func flip() -> [Value: Key] {
        var flippedDict: [Value: Key] = [:]
        for (key, value) in self {
            flippedDict[value] = key
        }
        return flippedDict
    }
}

/// Class containing all data storage lookup baased data
class Dictionaries {
    init() { }
    
    /// Dictionary containing all pickable clothing brands
    static let clothingBrandsEncode: [String: String] = [
        "Unkown": "UKN",
        "Nike": "NKE",
        "Adidas": "ADS",
        "Puma": "PMA",
        "Under Armour": "UAR",
        "Reebok": "RBK",
        "Gucci": "GCC",
        "Prada": "PRD",
        "Louis Vuitton": "LVN",
        "Versace": "VRS",
        "H&M": "HMM",
        "Zara": "ZRA",
        "Uniqlo": "UNQ",
        "Gap": "GAP",
        "Levi's": "LVS",
        "Tommy Hilfiger": "THG",
        "Ralph Lauren": "RLR",
        "Burberry": "BRB",
        "Calvin Klein": "CKL",
        "Balenciaga": "BLC",
        "Champion": "CHP",
        "Fendi": "FND",
        "Dolce & Gabbana": "DLG",
        "Valentino": "VAL",
        "Saint Laurent": "SYL",
        "Givenchy": "GVY",
        "Armani": "ARM",
        "Bershka": "BSK",
        "Forever 21": "FVR",
        "Old Navy": "OLD",
        "American Eagle": "AEG",
        "Abercrombie & Fitch": "ABF",
        "Guess": "GSS",
        "Lacoste": "LAC",
        "Converse": "CNV",
        "Vans": "VAN",
        "New Balance": "NBL",
        "Columbia": "CLB",
        "The North Face": "TNF",
        "Patagonia": "PTG",
        "Carhartt": "CRT",
        "Superdry": "SPD",
        "Jack & Jones": "JJN",
        "River Island": "RIV",
        "Mango": "MNG",
        "ASOS": "ASO",
        "Express": "EXP",
        "Banana Republic": "BNR",
        "J.Crew": "JCR",
        "Anthropologie": "ATH",
        "Free People": "FEP",
        "Urban Outfitters": "UOT",
        "Boohoo": "BOH",
        "Topshop": "TPS",
        "Massimo Dutti": "MSD",
        "C&A": "CAA",
        "Quiksilver": "QKS",
        "Billabong": "BIL",
        "Rip Curl": "RPC",
        "Oakley": "OKL",
        "Burton": "BUR",
        "Roxy": "ROX",
        "Superga": "SPG",
        "Brooks Brothers": "BKB",
        "Pendleton": "PDL",
        "Jil Sander": "JLS",
        "Ermenegildo Zegna": "EZG",
        "Hugo Boss": "HGB",
        "Moncler": "MNC",
        "Stone Island": "STI",
        "Kenzo": "KNZ",
        "Celine": "CEL",
        "Miu Miu": "MMU",
        "Saint Tropez": "STP",
        "Diesel": "DSL",
        "Replay": "RPL",
        "G-Star RAW": "GSR",
        "Lululemon": "LLM",
        "Fila": "FIL",
        "Undercover": "UNC",
        "Off-White": "OFF",
        "Balmain": "BLM",
        "Vetements": "VTM",
        "Acne Studios": "ACS",
        "Dr. Martens": "DRM",
        "UGG": "UGG",
        "Timberland": "TMB",
        "Skechers": "SKC",
        "Merrell": "MRL",
        "Reigning Champ": "RCH",
        "Stussy": "STY",
        "Obey": "OBY",
        "Kith": "KTH",
        "BAPE": "BAP",
        "Noah": "NOH",
        "A.P.C.": "APC",
        "Carven": "CRV",
        "Helmut Lang": "HML",
        "Dsquared2": "DSQ",
        "Stella McCartney": "STM",
        "Helly Hansen": "HLH"
    ]
    
    /// Dictionary containing all pickable sizes
    static let sizesEncode: [String: String] = [
        "XXS": "0",
        "XS": "1",
        "S": "2",
        "M": "3",
        "L": "4",
        "XL": "5",
        "XXL": "6",
        "3XL": "7",
        "4XL": "8",
        "5XL": "9",
        "Unkown": "10"
    ]
    
    /// Dictionary containing all pickable seasons
    static let seasonEncode: [String:String] = [
        "Winter": "0",
        "Spring": "1",
        "Summer": "2",
        "Fall": "3",
        "All Seasons": "4",
        "Unkown": "5"
    ]
    
    /// Dictionary containing all pickable materials
    static let materialEncode: [String: String] = [
        "Cotton":      "COT",
        "Wool":        "WOO",
        "Silk":        "SIL",
        "Linen":       "LIN",
        "Denim":       "DEN",
        "Cashmere":    "CAS",
        "Hemp":        "HEM",
        "Jute":        "JUT",
        "Ramie":       "RAM",
        "Bamboo":      "BAM",
        "Alpaca":      "ALP",
        "Angora":      "ANG",

        "Polyester":   "POL",
        "Nylon":       "NYL",
        "Acrylic":     "ACR",
        "Rayon":       "RAY",
        "Viscose":     "VIS",
        "Lyocell":     "LYO",
        "Modal":       "MOD",
        "Spandex":     "SPA",

        "Leather":     "LEA",
        "Chiffon":     "CHI",
        "Organza":     "ORG",
        "Taffeta":     "TAF",
        "Suede":       "SUE",
        "Flannel":     "FLA",
        "Mesh":        "MES",
        "Tulle":       "TUL",
        "Lace":        "LAC",
        "Canvas":      "CAN",
        "Gabardine":   "GAB",
        "Crepe":       "CRE",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable types of clothing
    static let typesEncode: [String: String] = [
        "Shirts": "SH",
        "Pants": "PT",
        "Dresses": "DR",
        "Skirts": "SK",
        "Coats": "CT",
        "Shorts": "ST",
        "Uunderwear": "UW",
        "Socks": "SC",
        "Bras": "BR",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable shirt fits
    static let shirtFitsEncode: [String: String] = [
        "Slim": "SL",
        "Regular": "RF",
        "Relaxed": "RX",
        "Oversized": "OV",
        "Boxy": "BX",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable pants fits
    static let pantsFitsEncode: [String: String] = [
        "Skinny Fit": "SK",
        "Slim Fit": "SL",
        "Regular Fit": "RG",
        "Relaxed Fit": "RX",
        "Loose Fit": "LS",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable dress fits
    static let dressFitsEncode: [String: String] = [
        "Bodycon": "BC",
        "A-Line": "AL",
        "Empire Waist": "EW",
        "Shift": "ST",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable skirt fits
    static let skirtFitsEncode: [String: String] = [
        "Pencil": "PL",
        "A-Line": "AL",
        "Pleated": "PT",
        "Maxi": "MX",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable coat fits
    static let coatFitsEncode: [String: String] = [
        "Tailored": "TD",
        "Regular": "RG",
        "Relaxed": "RX",
        "Oversized": "OV",
        "Fitted": "FT",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable shorts fits
    static let shortsFitsEncode: [String: String] = [
        "Slim": "SL",
        "Regular": "RG",
        "Relaxed": "RX",
        "Baggy Fit": "BG",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable underwaer fits
    static let underwearFitsEncode: [String: String] = [
        "Briefs": "BF",
        "Bikinis": "BK",
        "Thongs": "TG",
        "G-Strings": "GS",
        "Hipsters": "HP",
        "Boyshorts": "BS",
        "High-Waisted": "HW",
        "Seamless": "SS",
        "Control Briefs": "CB",
        "Cheeky": "CK",
        "Tanga": "TA",
        "French Cut": "FC",
        "C-String": "CS",
        "Boxers": "BX",
        "Boxer Briefs": "BB",
        "Jockstraps": "JS",
        "Long Johns": "LJ",
        "Maternity": "MY",
        "Thermal": "TH",
        "Postpartum": "PP",
        "Shapewear": "SW",
        "Tucking": "TK",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable sock fits
    static let sockFitsEncode: [String: String] = [
        "No-Show": "NS",
        "Ankle": "AK",
        "Crew": "CW",
        "Knee-High": "KH",
        "Over-the-Knee": "OK",
        "Thigh-High": "TH",
        "Toe": "TO",
        "Split-Toe": "ST",
        "Liner": "LR",
        "Dress": "DS",
        "Compression": "CP",
        "Thermal": "TH",
        "Sports": "SP",
        "Diabetic": "DB",
        "Unkown": "UKN"
    ]
    
    /// Dictionary containing all pickable braFits
    static let braFitsEncode: [String: String] = [
        "T-Shirt": "TS",
        "Push-Up": "PU",
        "Balconette": "BC",
        "Plunge": "PG",
        "Full-Coverage": "FC",
        "Demi-Cup": "DC",
        "Wireless": "WL",
        "Strapless": "SL",
        "Sports": "SP",
        "Bralette": "BT",
        "Mastectomy": "MS",
        "Nursing": "NR",
        "Convertible": "CV",
        "Minimizer": "MN",
        "Binder": "BR",
        "Unkown": "UKN"
    ]
    
    ///Flipped clothing brand Dictionary
    static let clothingBrandsDecode = clothingBrandsEncode.flip()
    ///Flipped size Dictionary
    static let sizesDecode = sizesEncode.flip()
    ///Flipped material Dictionary
    static let materialDecode = materialEncode.flip()
    ///Flipped types Dictionary
    static let typesDecode = typesEncode.flip()
    ///Flipped season Dictionary
    static let seasonDecode = seasonEncode.flip()
    ///Flipped shirt fits Dictionary
    static let shirtFitsDecode = shirtFitsEncode.flip()
    ///Flipped pant fits Dictionary
    static let pantsFitsDecode = pantsFitsEncode.flip()
    ///Flipped dress fits Dictionary
    static let dressFitsDecode = dressFitsEncode.flip()
    ///Flipped skirt fits Dictionary
    static let skirtFitsDecode = skirtFitsEncode.flip()
    ///Flipped coat fits Dictionary
    static let coatFitsDecode = coatFitsEncode.flip()
    ///Flipped short fits Dictionary
    static let shortsFitsDecode = shortsFitsEncode.flip()
    ///Flipped underwear fits Dictionary
    static let underwearFitsDecode = underwearFitsEncode.flip()
    ///Flipped sock fits Dictionary
    static let sockFitsDecode = sockFitsEncode.flip()
    ///Flipped bra fits Dictionary
    static let braFitsDecode = braFitsEncode.flip()
    
    
    
    /// To get the the fit code from any random fit name and the type of clothing
    /// - Parameters:
    ///   - fitS: The normal name of the piece
    ///   - typeC: the type of clothing
    /// - Returns: The proper fit code corilatiing with the previded name
    func getFitCode(fitS: String, typeC: String) -> String {
        var fitC: String = ""
        switch getTypeString(typeC: typeC) {
        case "Shirt":
            fitC = Dictionaries.shirtFitsEncode[fitS]!
        case "Pant":
            fitC = Dictionaries.pantsFitsEncode[fitS]!
        case "Dresse":
            fitC = Dictionaries.dressFitsEncode[fitS]!
        case "Skirt":
            fitC = Dictionaries.skirtFitsEncode[fitS]!
        case "Coat":
            fitC = Dictionaries.coatFitsEncode[fitS]!
        case "Shorts":
            fitC = Dictionaries.shortsFitsEncode[fitS]!
        case "Underwear":
            fitC = Dictionaries.underwearFitsEncode[fitS]!
        case "Socks":
            fitC = Dictionaries.sockFitsEncode[fitS]!
        case "Bra":
            fitC = Dictionaries.braFitsEncode[fitS]!
        default:
            fitC = "ER"
        }
        return fitC
    }
    
    
    /// Function to retrieve the dictionary for any type of clothing
    /// - Parameters:
    ///   - piece: The piece provided so the type can be retrieved
    ///   - flipped: Boolean if the returned dictionary should be flipped or not
    /// - Returns: The retrieved dictionary for the pieces fit according to its type
    func getFitDictionary(piece: Piece, flipped: Bool) -> [String:String] {
        var placeHolderDictionary: [String:String] = [:]
        
        switch piece.type {
        case "SHIRTS":
            placeHolderDictionary = Dictionaries.shirtFitsEncode
        case "PANTS":
            placeHolderDictionary = Dictionaries.pantsFitsEncode
        case "DRESS":
            placeHolderDictionary = Dictionaries.dressFitsEncode
        case "SKIRTS":
            placeHolderDictionary = Dictionaries.skirtFitsEncode
        case "COAT":
            placeHolderDictionary = Dictionaries.coatFitsEncode
        case "SHORTS":
            placeHolderDictionary = Dictionaries.shortsFitsEncode
        case "UNDERWEAR":
            placeHolderDictionary = Dictionaries.underwearFitsEncode
        case "SOCKS":
            placeHolderDictionary = Dictionaries.sockFitsEncode
        case "BRA":
            placeHolderDictionary = Dictionaries.braFitsEncode
        default:
            break
        }
        
        if flipped == true {
            return placeHolderDictionary.flip()
        } else {
            return placeHolderDictionary
        }
    }
    
    /// Function to get the String of the type
    /// - Parameter typeC: The Code for the Type
    /// - Returns: The String of the Type (Normal Name)
    func getTypeString(typeC: String) -> String {
        var typeS: String = ""
        typeS = Dictionaries.typesDecode[typeC]!
        return typeS
    }
}


/// Class that is reponable for maintaine the storage of the dictionaries to ensure proper data retrieval
class DictionaryStorage {
    private let filename = "ClosetIdFile.json"
    
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
    
    /// Function to save the dictionaries
    /// - Parameter dictionary: The dictionary being sent to save
    func save(dictionary: [String:[String]]) {
        do {
            let data = try JSONEncoder().encode(dictionary)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save dictionary:", error)
        }
    }
    
    /// Function to load dictonaries from storage
    /// - Returns: The dictionary that should be stored
    func load() -> [String:[String]] {
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode([String:[String]].self, from: data)
        } catch {
            print("Failed to load dictionary:", error)
            return [:]
        }
    }
}
