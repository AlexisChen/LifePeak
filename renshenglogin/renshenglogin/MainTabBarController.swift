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
        //set color schemes
        tabBar.items?.forEach({ (tabBarItem) in
            tabBarItem.image = tabBarItem.image?.withRenderingMode(.alwaysOriginal)
            tabBarItem.title = nil
        })
        tabBar.tintColor = UIColor(red: 0.8, green: 0.75, blue: 0.95, alpha: 0.5)
        
        //self.selectedViewController = self.viewControllers?[2]

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
