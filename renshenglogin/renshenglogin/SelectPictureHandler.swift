//
//  SelectPictureHandler.swift
//  renshenglogin
//
//  Created by Cynthia Gao on 6/28/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit

extension NewPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func handleSelectPicture(){
        let picker = UIImagePickerController ()

        picker.delegate = self
        //picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        var selectedImageFromPicker: UIImage?
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            PostImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss (animated: true, completion: nil)
    }
}
