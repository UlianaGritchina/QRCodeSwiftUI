//
//  PhotoPicker.swift
//  Test
//
//  Created by Ульяна Гритчина on 12.04.2022.
//

import SwiftUI

final class PhotoPickerViewModel: ObservableObject {
   @Published var imageData: Data?
}

struct PhotoPickerView: UIViewControllerRepresentable {
    let vm: PhotoPickerViewModel
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self, vm: vm)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let photoPicker: PhotoPickerView
        let vm: PhotoPickerViewModel
        
        init(photoPicker: PhotoPickerView, vm: PhotoPickerViewModel) {
            self.photoPicker = photoPicker
            self.vm = vm
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.pngData() else {
                    return
                }
                vm.imageData = data
                
            } else {
                
            }
            picker.dismiss(animated: true)
        }
    }
    
}
