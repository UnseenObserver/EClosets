//
//  nameAlertPopUp.swift
//  ECloset
//
//  Created by Student on 4/23/25.
//

import SwiftUI

struct TextFieldAlertModifier: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let title: String
    let message: String?
    let placeholder: String
    let action: (String?) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

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
