//
//  SettingsViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 2/11/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var usernamecontent: UITextField!
    @IBOutlet weak var bio: UITextView!
    
    var ref: DatabaseReference! = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
        UserDefaults.standard.synchronize();
        //self.performSegue(withIdentifier: "ContentToLogin", sender: self);
        self.dismiss(animated: true, completion: nil);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernamecontent.resignFirstResponder()
        self.bio.resignFirstResponder()
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        
        let confirmAlert = UIAlertController(title: "",  message: "Sure to save changes?",  preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default){action in
            if(self.usernamecontent.text == nil || self.bio.text == nil){}
            else{
            let userObject: Dictionary<String, Any> = [
                "username" : self.usernamecontent.text!,
                "bio" : self.bio.text
            ]
            if let uid = Auth.auth().currentUser?.uid{
                self.ref.child("Users").child(uid).setValue(userObject)
            }
            }
            self.dismiss(animated: true, completion: nil);
        }
        let cancelAction = UIAlertAction(title:"cancel", style: UIAlertActionStyle.cancel){ (action:UIAlertAction!) in
        }
        confirmAlert.addAction(okAction);
        confirmAlert.addAction(cancelAction);
        self.present(confirmAlert, animated: true, completion: nil);
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
