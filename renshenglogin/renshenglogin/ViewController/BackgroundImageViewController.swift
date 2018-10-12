//
//  BackgroundImageViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 10/10/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import Foundation
import UIKit

class BackgroundImageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Backgroud")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill

        self.view.insertSubview(backgroundImage, at: 0)
    }
}
