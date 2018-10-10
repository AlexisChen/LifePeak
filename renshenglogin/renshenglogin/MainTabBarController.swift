//
//  MainTabBarController.swift
//  renshenglogin
//
//  Created by Cynthia Gao on 7/18/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
     let postHandler = MediaSelector ()
    
    override func viewDidLoad () {
        super.viewDidLoad ()
        
         postHandler.completionHandler = { image in
            //create the post for images
            NewPostHandler.create(for: image)
        }
        
        delegate = self
        tabBar.unselectedItemTintColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        }
    
}


extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 1 {
            print("take photo")
            return false
        } else {
            return true
        }
    }
}
