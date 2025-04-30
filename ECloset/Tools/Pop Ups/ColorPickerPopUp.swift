//
//  ColorPickerPopUp.swift
//  ECloset
//
//  Created by Charlotte Pawloski on 4/23/25.
//

import SwiftUI

/// Creation and calling of the color picker pop up which allows for the native disigened color experiance in swiftUI
struct ColorPickerPopUp: UIViewControllerRepresentable {
    private let delegate: ColorPickerDelegate
    private let pickerTitle: String
    private let selectedColor: UIColor

    init(title: String, selectedColor: Color, didSelectColor: @escaping ((Color) -> Void)) {
        self.pickerTitle = title
        self.selectedColor = UIColor(selectedColor)
        self.delegate = ColorPickerDelegate(didSelectColor)
    }
 
    /// Making the Color PIcker in the Views context
    /// - Parameter context: The context of the View
    /// - Returns: The color picker to be displayed
    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let colorPickerController = UIColorPickerViewController()
        colorPickerController.delegate = delegate
        colorPickerController.title = pickerTitle
        colorPickerController.selectedColor = selectedColor
        return colorPickerController
    }

    /// Updating the view controller
    /// - Parameters:
    ///   - uiViewController: The UIView to be updated
    ///   - context: The context in which it should be updated
    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {}
}
