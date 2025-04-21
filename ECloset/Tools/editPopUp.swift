//
//  editPopUp.swift
//  ECloset
//
//  Created by HPro2 on 4/21/25.
//

import SwiftUICore
import SwiftUI

struct editPopUp {
    @State var changing: String
    @State var dictionary: [String:String]
    
    var body: some View {
        VStack {
            Section(changing) {
                List(dictionary.keys.sorted(), id: \.self) { key in
                    Text(key)
                }
            }
        }
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.90)).shadow(radius: 5))
    }
}
