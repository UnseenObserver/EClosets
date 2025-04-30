//
//  nameAlertPopUp.swift
//  ECloset
//
//  Created by Charlotte Pawloski on 4/23/25.
//

import SwiftUI

/// Bridge to make an alert that can change a variable by a user inputed textFeild in swift
struct TextFieldAlertModifier: UIViewControllerRepresentable {
    /// Boolean for if the alert is presented
    @Binding var isPresented: Bool
    /// Title of the alert
    let title: String
    /// Optional message to be displayed on the alert
    let message: String?
    /// Placeholder text int he textFeild
    let placeholder: String
    /// The Action done by the alert
    let action: (String?) -> Void

    
    /// Making a UIViewController
    /// - Parameter context: The context of the view its is to be built in
    /// - Returns: A UIViewController
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    
    /// Updating the created viewController
    /// - Parameters:
    ///   - uiViewController: The controller that should be updated
    ///   - context: The context in which it should be updated
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard isPresented else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = placeholder
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            isPresented = false
        })

        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            let text = alert.textFields?.first?.text
            isPresented = false
            action(text)
        })

        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true, completion: nil)
        }
    }
}
