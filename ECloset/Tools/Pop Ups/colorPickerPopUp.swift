//
//  colorPickerPopUp.swift
//  ECloset
//
//  Created by Student on 4/23/25.
//

import SwiftUICore
import SwiftUI

struct colorPickerPopUp: View {
    @State var selectedColor: CGColor
   
    var body: some View {
        VStack {
            ColorPicker("", selection: $selectedColor)
                .frame(width: 100, height: 100)
                .scaleEffect(5)
        }
    }
    
    
}
