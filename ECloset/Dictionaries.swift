import Foundation

extension Dictionary where Value: Hashable {
    func flip() -> [Value: Key] {
        var flippedDict: [Value: Key] = [:]
        for (key, value) in self {
            flippedDict[value] = key
        }
        return flippedDict
    }
}

class Dictionaries {
    init() { }
    
    static let clothingBrandsEncode: [String: String] = [
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
        "5XL": "9"
    ]
    
    static let seasonEncode: [String:String] = [
        "Winter": "0",
        "Spring": "1",
        "Summer": "2",
        "Fall": "3"
    ]
    
    static let materialsEncode: [String: String] = [
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
        "Crepe":       "CRE"
    ]
    
    static let typesEncode: [String: String] = [
        "SHIRTS": "SH",
        "PANTS": "PT",
        "DRESS": "DR",
        "SKIRT": "SK",
        "COAT": "CT",
        "SHORTS": "ST",
        "UNDERWEAR": "UW",
        "SOCKS": "SC",
        "BRA": "BR"
    ]
    
    static let shirtFitsEncode: [String: String] = [
        "Slim": "SL",
        "Regular": "RF",
        "Relaxed": "RX",
        "Oversized": "OV",
        "Boxy": "BX"
    ]
    
    static let pantsFitsEncode: [String: String] = [
        "Skinny Fit": "SK",
        "Slim Fit": "SL",
        "Regular Fit": "RG",
        "Relaxed Fit": "RX",
        "Loose Fit": "LS"
    ]
    
    static let dressFitsEncode: [String: String] = [
        "Bodycon": "BC",
        "A-Line": "AL",
        "Empire Waist": "EW",
        "Shift": "ST"
    ]
    
    static let skirtFitsEncode: [String: String] = [
        "Pencil": "PL",
        "A-Line": "AL",
        "Pleated": "PT",
        "Maxi": "MX"
    ]
    
    static let coatFitsEncode: [String: String] = [
        "Tailored": "TD",
        "Regular": "RG",
        "Relaxed": "RX",
        "Oversized": "OV",
        "Fitted": "FT"
    ]
    
    static let shortsFitsEncode: [String: String] = [
        "Slim": "SL",
        "Regular": "RG",
        "Relaxed": "RX",
        "Baggy Fit": "BG"
    ]
    
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
        "Tanga": "TG",
        "French Cut": "FC",
        "C-String": "CS",
        "Boxers": "BX",
        "Boxer Briefs": "BB",
        "Jockstraps": "JS",
        "Long Johns": "LJ",
        "Maternity": "My",
        "Thermal": "TH",
        "Postpartum": "PP",
        "Shapewear": "SW"
    ]
    
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
        "Diabetic": "DB"
    ]
    
    static let braFitsEncode: [String: String] = [
        "T-Shirt Bra": "TS",
        "Push-Up Bra": "PU",
        "Balconette Bra": "BC",
        "Plunge Bra": "PG",
        "Full-Coverage Bra": "FC",
        "Demi-Cup Bra": "DC",
        "Wireless Bra": "WL",
        "Strapless Bra": "SL",
        "Sports Bra": "SP",
        "Bralette": "BT",
        "Mastectomy Bra": "MS",
        "Nursing Bra": "NR",
        "Convertible Bra": "CV",
        "Minimizer Bra": "MN"
    ]
    
    static let clothingBrandsDecode = clothingBrandsEncode.flip()
    static let sizesDecode = sizesEncode.flip()
    static let materialDecode = materialsEncode.flip()
    static let typesDecode = typesEncode.flip()
    static let seasonDecode = seasonEncode.flip()
    static let shirtFitsDecode = shirtFitsEncode.flip()
    static let pantsFitsDecode = pantsFitsEncode.flip()
    static let dressFitsDecode = dressFitsEncode.flip()
    static let skirtFitsDecode = skirtFitsEncode.flip()
    static let coatFitsDecode = coatFitsEncode.flip()
    static let shortsFitsDecode = shortsFitsEncode.flip()
    static let underwearFitsDecode = underwearFitsEncode.flip()
    static let sockFitsDecode = sockFitsEncode.flip()
    static let braFitsDecode = braFitsEncode.flip()
    
    
    //Dictionary Stuff
    func getFitCode(fitS: String, typeC: String) -> String {
        var fitC: String = ""
        switch getTypeString(typeC: typeC) {
        case "SHIRT":
            fitC = Dictionaries.shirtFitsEncode[fitS]!
        case "PANTS":
            fitC = Dictionaries.pantsFitsEncode[fitS]!
        case "DRESS":
            fitC = Dictionaries.dressFitsEncode[fitS]!
        case "SKIRT":
            fitC = Dictionaries.skirtFitsEncode[fitS]!
        case "COAT":
            fitC = Dictionaries.coatFitsEncode[fitS]!
        case "SHORTS":
            fitC = Dictionaries.shortsFitsEncode[fitS]!
        case "UNDERWEAR":
            fitC = Dictionaries.underwearFitsEncode[fitS]!
        case "SOCK":
            fitC = Dictionaries.sockFitsEncode[fitS]!
        case "BRA":
            fitC = Dictionaries.braFitsEncode[fitS]!
        default:
            fitC = "ER"
        }
        return fitC
    }
    
    func getTypeCode(typeS: String) -> String {
        var typeC: String = ""
        typeC = Dictionaries.typesEncode[typeS]!
        return typeC
    }
    
    func getSizeCode(sizeS: String) -> String {
        var sizeC = ""
        sizeC = Dictionaries.sizesEncode[sizeS]!
        return sizeC
    }
    
    func getBrandCode(brandS: String) -> String {
        var brandC: String = ""
        brandC = Dictionaries.clothingBrandsEncode[brandS]!
        return brandC
    }
    
    func getFitString(fitC: String, typeC: String) -> String {
        var fitS: String = ""
        switch getTypeString(typeC: typeC) {
        case "SHIRT":
            fitS = Dictionaries.shirtFitsEncode[fitC]!
        case "PANTS":
            fitS = Dictionaries.pantsFitsEncode[fitC]!
        case "DRESS":
            fitS = Dictionaries.dressFitsEncode[fitC]!
        case "SKIRT":
            fitS = Dictionaries.skirtFitsEncode[fitC]!
        case "COAT":
            fitS = Dictionaries.coatFitsEncode[fitC]!
        case "SHORTS":
            fitS = Dictionaries.shortsFitsEncode[fitC]!
        case "UNDERWEAR":
            fitS = Dictionaries.underwearFitsEncode[fitC]!
        case "SOCK":
            fitS = Dictionaries.sockFitsEncode[fitC]!
        case "BRA":
            fitS = Dictionaries.braFitsEncode[fitC]!
        default:
            fitS = "ER"
        }
        return fitS
    }
    
    func getTypeString(typeC: String) -> String {
        var typeS: String = ""
        typeS = Dictionaries.typesDecode[typeC]!
        return typeS
    }
    
    func getSizeInt(sizeC: String) -> String {
        var sizeS = ""
        sizeS = Dictionaries.sizesDecode[sizeC]!
        return sizeS
    }
    
    func getBrandString(brandC: String) -> String {
        var brandS: String = ""
        brandS = Dictionaries.clothingBrandsDecode[brandC]!
        return brandS
    }
    
}


class DictionaryStorage {
    private let filename = "ClosetIdFile.json"
    
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
    
    func save(dictionary: [String:[String]]) {
        do {
            let data = try JSONEncoder().encode(dictionary)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Failed to save dictionary:", error)
        }
    }
    
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
