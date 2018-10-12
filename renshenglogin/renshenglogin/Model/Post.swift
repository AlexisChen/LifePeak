//
//  Post.swift
//  renshenglogin
//
//  Created by Cynthia Gao on 7/27/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    init(imageURL: String, imageHeight: CGFloat) {
    self.imageURL = imageURL
    self.imageHeight = imageHeight
    self.creationDate = Date()
    }
    
    var key: String?
    let imageURL: String
    let imageHeight: CGFloat
    let creationDate: Date

}




