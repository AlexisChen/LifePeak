//
//  RegisterViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 1/27/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    var prefilledEmail: String = ""
    var prefilledPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.text = prefilledEmail
        userPasswordTextField.text = prefilledPassword
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
        userRepeatPasswordTextField.resignFirstResponder()
    }
    
    

    @IBAction func registerButtonTapped(sender: Any) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        let userRepeatPassword = userRepeatPasswordTextField.text;
        
        //check for empty fields
        if((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userRepeatPassword?.isEmpty)!){
            //display alert message: field empty
            displayAlertMessage(usermessage: "All fields are required.");
            return;
        }
        //check if passwords match
        if(userPassword != userRepeatPassword){
            //display alert message: password not identical
            displayAlertMessage(usermessage: "Passwords do not match.");
            return;
        }
        //store data
        Auth.auth().createUser(withEmail: userEmail!, password: userPassword!, completion: {(user, error) in
            if user != nil {
                Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                    Auth.auth().currentUser?.sendEmailVerification { (error) in
                        if let err = error {
                            self.displayAlertMessage(usermessage: "Email Confirmation Sent Error!\n" + err.localizedDescription)
                        } else {
                            let confirmAlert = UIAlertController(title: "Thanks!",  message: "Registration is successful! \n An email confirmation has been sent to: \(Auth.auth().currentUser?.email! ?? "") \n Please confirma and log in",  preferredStyle: UIAlertControllerStyle.alert);
                            let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default){action in
                                self.dismiss(animated: true, completion: nil);
                            }
                            confirmAlert.addAction(okAction);
                            self.present(confirmAlert, animated: true, completion: nil);
                        }
                    }
                })
            }
            
            else{
                if let error = error{
                    switch AuthErrorCode(rawValue: error._code){
                    case .emailAlreadyInUse?:
                        self.displayAlertMessage(usermessage: "Email is already in use")
                        break
                    case .invalidEmail?:
                        self.displayAlertMessage(usermessage: "Email format is invalid")
                        break
                    case .networkError?:
                        self.displayAlertMessage(usermessage: "Network error pls try again")
                        break
                    case .weakPassword?:
                        self.displayAlertMessage(usermessage: "Your Password is too weak")
                        break
                    default:
                        self.displayAlertMessage(usermessage: "UnKnown Error")
                        break
                      
                    }
                }
            }
        })
    }
    
    @IBAction func Clear(_ sender: Any) {
        userEmailTextField.text = "";
        userPasswordTextField.text = "";
        userRepeatPasswordTextField.text = "";
    }
    
    func displayAlertMessage(usermessage: String)
    {
        let myAlert = UIAlertController(title: "Oopsie", message: usermessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"ok", style: UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
    }
    @IBAction func retryLoginTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);
    }
}
