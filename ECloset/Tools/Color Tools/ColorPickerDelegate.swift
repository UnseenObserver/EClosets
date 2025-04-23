//
//  ColorPickerDelegate.swift
//  ECloset
//
//  Created by HPro2 on 4/23/25.
//

import UIKit
import SwiftUICore

class ColorPickerDelegate: NSObject, UIColorPickerViewControllerDelegate {
    var didSelectColor: ((Color) -> Void)
    
    init(_ didSelectColor: @escaping ((Color) -> Void)) {
        self.didSelectColor = didSelectColor
    }
    
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        let selectedUIColor = viewController.selectedColor
        didSelectColor(Color(uiColor: selectedUIColor))
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        print("dismiss colorPicker")
    }

}
