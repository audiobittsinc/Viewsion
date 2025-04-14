//
//  DocumentPicker.swift
//  Viewsion
//
//  Created by Denzil Dsa on 10/5/21.
//  Copyright © 2021 AudioBitts Inc. All rights reserved.
//

import Foundation
import SwiftUI
import MobileCoreServices

struct MoviePicker: UIViewControllerRepresentable {
    @Binding var fileUrl: URL
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> MoviePickerCoordinator {
        return MoviePickerCoordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MoviePicker>) -> UIDocumentPickerViewController {
        let controller: UIDocumentPickerViewController
        if #available(iOS 14, *) {
            controller = UIDocumentPickerViewController(forOpeningContentTypes: [.mpeg4Movie,.movie], asCopy: true)
        } else {
            controller = UIDocumentPickerViewController(documentTypes: [String(kUTTypeMovie)], in: .import)
        }
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<MoviePicker>) {
    }
}

class MoviePickerCoordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    var parent: MoviePicker
    init(_ parent: MoviePicker) {
        self.parent = parent
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let url = urls[0] as? URL {
            do {
                print(url)
                let dstURL = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
                print("this is the ")
                print(dstURL)
                parent.fileUrl = dstURL
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: dstURL.path) {
                    print("movie saved \(dstURL)")
                } else {
                    try FileManager.default.moveItem(at: url, to: dstURL)
                }
            } catch {
                print(error)
            }
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var fileUrl: URL
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> ImagePickerCoordinator {
        return ImagePickerCoordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIDocumentPickerViewController {
        let controller: UIDocumentPickerViewController
        if #available(iOS 14, *) {
            controller = UIDocumentPickerViewController(forOpeningContentTypes: [.image], asCopy: true)
        } else {
            controller = UIDocumentPickerViewController(documentTypes: [String(kUTTypeJPEG),String(kUTTypePNG),String(kUTTypeBMP)], in: .import)
        }
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
}

class ImagePickerCoordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
    var parent: ImagePicker
    
    init(_ parent: ImagePicker) {
        self.parent = parent
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let url = urls[0] as? URL {
            do {
                print(url)
                let dstURL = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
                print(dstURL)
                parent.fileUrl = dstURL
                if dstURL.startAccessingSecurityScopedResource() {
                    try FileManager.default.moveItem(at: url, to: dstURL)
                }
                dstURL.stopAccessingSecurityScopedResource()
                print("image saved \(dstURL)")
            } catch {
                print("Error cpying file")
            }
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
}


struct GalleryPicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var fileUrl: URL
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> GalleryPickerCoordinator {
        return GalleryPickerCoordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GalleryPicker>) -> UIImagePickerController {
        let galleryPicker = UIImagePickerController()
        galleryPicker.allowsEditing = false
        galleryPicker.sourceType = sourceType
        galleryPicker.delegate = context.coordinator
        galleryPicker.mediaTypes = ["public.movie"]
        return galleryPicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<GalleryPicker>) {
        
    }
}

class GalleryPickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: GalleryPicker
    
    init(_ parent: GalleryPicker) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        if let url = info[.mediaURL] as? URL {
            do {
                print(url)
                let dstURL = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent)
                print(dstURL)
                parent.fileUrl = dstURL
                
                if dstURL.startAccessingSecurityScopedResource() {
                    // need permissions to moveItem
                    try! FileManager.default.moveItem(at: url, to: dstURL)
                    // try copyItem
                    //try! FileManager.default.copyItem(at: url, to: dstURL)
                }
                dstURL.stopAccessingSecurityScopedResource()
                print("media copied \(dstURL)")
            } catch {
                print(error.localizedDescription)
            }
        }
        parent.presentationMode.wrappedValue.dismiss()
    }
}
