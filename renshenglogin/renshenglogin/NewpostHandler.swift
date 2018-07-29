//
//  NewPostHandler.swift
//  renshenglogin
//
//  Created by Cynthia Gao on 7/19/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct NewPostHandler {
    static func create(for image: UIImage) {
        let imageRef = Storage.storage().reference().child("postImage.jpg")
        UploadtoStorage.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            let urlString = downloadURL.absoluteString
        }
    }
}

