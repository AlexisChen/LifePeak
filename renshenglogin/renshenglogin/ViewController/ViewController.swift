//
//  ViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 1/27/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn");
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        if(!isUserLoggedIn){
             self.performSegue(withIdentifier: "ContentToLogin", sender: self);
        }
    }
   
}

