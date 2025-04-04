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

    static let clothingBrandsF: [String: String] = [
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

    static let sizesF: [String: Int] = [
        "XXS": 0,
        "XS": 1,
        "S": 2,
        "M": 3,
        "L": 4,
        "XL": 5,
        "XXL": 6,
        "3XL": 7,
        "4XL": 8,
        "5XL": 9
    ]

    static let typesF: [String: String] = [
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

    static let shirtFitsF: [String: String] = [
        "Slim": "SL",
        "Regular": "RF",
        "Relaxed": "RX",
        "Oversized": "OV",
        "Boxy": "BX"
    ]

    static let pantsFitsF: [String: String] = [
        "Skinny Fit": "SK",
        "Slim Fit": "SL",
        "Regular Fit": "RG",
        "Relaxed Fit": "RX",
        "Loose Fit": "LS"
    ]

    static let dressFitsF: [String: String] = [
        "Bodycon": "BC",
        "A-Line": "AL",
        "Empire Waist": "EW",
        "Shift": "ST"
    ]

    static let skirtFitsF: [String: String] = [
        "Pencil": "PL",
        "A-Line": "AL",
        "Pleated": "PT",
        "Maxi": "MX"
    ]

    static let coatFitsF: [String: String] = [
        "Tailored": "TD",
        "Regular": "RG",
        "Relaxed": "RX",
        "Oversized": "OV",
        "Fitted": "FT"
    ]

    static let shortsFitsF: [String: String] = [
        "Slim": "SL",
        "Regular": "RG",
        "Relaxed": "RX",
        "Baggy Fit": "BG"
    ]

    static let underwearFitsF: [String: String] = [
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

    static let sockFitsF: [String: String] = [
        "No-Show Socks": "NS",
        "Ankle Socks": "AK",
        "Crew Socks": "CW",
        "Knee-High Socks": "KH",
        "Over-the-Knee Socks": "OK",
        "Thigh-High Socks": "TH",
        "Toe Socks": "TO",
        "Split-Toe Socks (Tabi)": "ST",
        "Liner Socks": "LR",
        "Dress Socks": "DS",
        "Compression Socks": "CP",
        "Thermal Socks": "TH",
        "Sports Socks": "SP",
        "Diabetic Socks": "DB"
    ]

    static let braFitsF: [String: String] = [
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

    static let clothingBrandsP = clothingBrandsF.flip()
    static let sizesP = sizesF.flip()
    static let typesP = typesF.flip()
    static let shirtFitsP = shirtFitsF.flip()
    static let pantsFitsP = pantsFitsF.flip()
    static let dressFitsP = dressFitsF.flip()
    static let skirtFitsP = skirtFitsF.flip()
    static let coatFitsP = coatFitsF.flip()
    static let shortsFitsP = shortsFitsF.flip()
    static let underwearFitsP = underwearFitsF.flip()
    static let sockFitsP = sockFitsF.flip()
    static let braFitsP = braFitsF.flip()
}
