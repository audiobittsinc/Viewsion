//
//  ProfileImagePicker.swift
//  Viewsion
//
//  Created by Denzil Dsa on 11/27/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct ProfileImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    @Binding var url: URL?
    
    func makeCoordinator() -> ProfileImageCoordinator {
        ProfileImageCoordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ProfileImagePicker>) {
    }
}

class ProfileImageCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ProfileImagePicker
    
    init(_ parent: ProfileImagePicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            parent.image = uiImage
        }
        if let url = info[.imageURL] as? URL {
            parent.url = url
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
}
