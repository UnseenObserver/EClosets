//
//  ColorPickerDelegate.swift
//  ECloset
//
//  Created by Charlotte Pawloski on 4/23/25.
//

import UIKit
import SwiftUICore

/// Bridge to bring the UIKit color picker into swiftUI
class ColorPickerDelegate: NSObject, UIColorPickerViewControllerDelegate {
    var didSelectColor: ((Color) -> Void)
    
    init(_ didSelectColor: @escaping ((Color) -> Void)) {
        self.didSelectColor = didSelectColor
    }
    
    /// Creation of the colorPickerView
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let selectedUIColor = viewController.selectedColor
        didSelectColor(Color(uiColor: selectedUIColor))
    }

    /// Degug function to know when the colorPicker is dismissed
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("dismiss colorPicker")
    }

}
