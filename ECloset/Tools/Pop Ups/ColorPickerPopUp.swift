//
//  ColorPickerPopUp.swift
//  ECloset
//
//  Created by HPro2 on 4/23/25.
//

import SwiftUI

struct ColorPickerPopUp: UIViewControllerRepresentable {
    private let delegate: ColorPickerDelegate
    private let pickerTitle: String
    private let selectedColor: UIColor

    init(title: String, selectedColor: Color, didSelectColor: @escaping ((Color) -> Void)) {
        self.pickerTitle = title
        self.selectedColor = UIColor(selectedColor)
        self.delegate = ColorPickerDelegate(didSelectColor)
    }
 
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let colorPickerController = UIColorPickerViewController()
        colorPickerController.delegate = delegate
        colorPickerController.title = pickerTitle
        colorPickerController.selectedColor = selectedColor
        return colorPickerController
    }

 
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {}
}
