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

class SettingsViewController: BackgroundImageViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var bioTextView: UITextView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                if let userInfo = snapshot.value as? NSDictionary {
                    self.usernameTextField.text = userInfo["username"] as? String ?? ""
                    self.bioTextView.text = userInfo["bio"] as? String ?? ""
                }
            }
        }
        usernameTextField.delegate = self;
        bioTextView.delegate = self;
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.usernameTextField.resignFirstResponder()
        self.bioTextView.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishEditingUsername()
        return false;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        finishEditingUsername()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = .white
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = .clear
        textView.resignFirstResponder()
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        if bioTextView.isFirstResponder {
            bioTextView.resignFirstResponder()
        }
        if usernameTextField.isFirstResponder {
            usernameTextField.resignFirstResponder()
        }
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn");
        UserDefaults.standard.synchronize();
        //self.performSegue(withIdentifier: "ContentToLogin", sender: self);
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func okButtonTapped(_ sender: Any) {
        
        let confirmAlert = UIAlertController(title: "",  message: "Sure to save changes?",  preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default){action in
            if(!self.usernameTextField.text!.isEmpty && !self.bioTextView.text.isEmpty) {
                if let uid = Auth.auth().currentUser?.uid{
                    self.ref.child("Users").child(uid).updateChildValues(["username" : self.usernameTextField.text!])
                    self.ref.child("Users").child(uid).updateChildValues(["bio" : self.bioTextView.text])
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
    
    func finishEditingUsername() {
        usernameTextField.backgroundColor = .clear
        usernameTextField.resignFirstResponder()
    }

}
