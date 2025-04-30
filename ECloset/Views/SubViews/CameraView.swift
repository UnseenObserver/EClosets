//
//  ClosetCell.swift
//  EClosets
//
//  Created by Charlotte Pawloski on 3/21/25.

import SwiftUI
import UIKit

/// View used to use the camera to add photos to the piece being added or editted
struct CameraView: UIViewControllerRepresentable {
    /// Global value for the presintaion mode of the view
    @Environment(\.presentationMode) var presentationMode
    /// The data of the image picked
    var onImagePicked: (Data) -> Void
    
    /// Function to create the camera cordinator to create the camera view
    /// - Returns: Returns the created camera coordinator
    func makeCoordinator() -> CameraCoordinator {
        CameraCoordinator(parent: self)
    }
    
    /// Creates the UIViewControler for the camera
    /// - Parameter context: The context in which the view should be displayed
    /// - Returns: The UIImagePickerController Which allows for image retrieveal
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        #if targetEnvironment(simulator)
        picker.sourceType = .photoLibrary  // 👈 fallback when testing
        #else
        picker.sourceType = .camera
        #endif

        picker.allowsEditing = false
        return picker
    }

    
    /// Updates the CameraViewController
    /// - Parameters:
    ///   - uiViewController: The view controller that should be updated
    ///   - context: The context of the view controller that should be updated
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

/// The Camera Coordinator which function as a bridge to different apple packages allowing for the functions of the camera view
class CameraCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    /// The parent View of the camera coordinator
    let parent: CameraView

    init(parent: CameraView) {
        self.parent = parent
    }
    
    /// The init for the imagePicker Controller which allows for pictures to be taken
    /// - Parameters:
    ///   - picker: The Picker for the diffenet packages that should be used
    ///   - info: The info required to be sent to the UIImagePickerViewController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage,
           let imageData = image.jpegData(compressionQuality: 1) {
            parent.onImagePicked(imageData)
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
    
    /// Function to cancel the ViewController
    /// - Parameter picker: Which ViewController to cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.presentationMode.wrappedValue.dismiss()
    }
}
