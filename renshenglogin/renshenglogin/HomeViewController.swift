//
//  HomeViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 2/11/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
        if(!isUserLoggedIn){
            self.dismiss(animated: true, completion: nil);
        }
    }*/
    
    @IBAction func backToFeedTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}
