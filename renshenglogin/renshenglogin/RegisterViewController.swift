//
//  RegisterViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 1/27/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            if (user != nil){
                let confirmAlert = UIAlertController(title: "Thanks!",  message: "Registration is successful!",  preferredStyle: UIAlertControllerStyle.alert);
                let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default){action in
                    self.dismiss(animated: true, completion: nil);
                }
                confirmAlert.addAction(okAction);
                self.present(confirmAlert, animated: true, completion: nil);

            }
            
            else{
                if let error = error{
                    switch AuthErrorCode(rawValue: error._code){
                    case .emailAlreadyInUse?:
                        self.displayAlertMessage(usermessage: "Email is already in use")
                        print("in use")
                        break
                    case .invalidEmail?:
                        self.displayAlertMessage(usermessage: "Email format is invalid")
                        break
                    case .networkError?:
                        self.displayAlertMessage(usermessage: "Network error pls try again")
                        break
                  
                        
                    default:
                       
                        break
                      
                    }
                   // self.displayAlertMessage(usermessage: myError);
                }else{
                    //self.displayAlertMessage(usermessage: "This account haven't registered, please register first");
                }
            }
        }
        )
        
        /*
         //using local storage
        let defaults = UserDefaults.standard;
        defaults.set(userEmail, forKey: "userEmail");
        defaults.set(userPassword, forKey: "userPassword");
        defaults.synchronize();
        */
        //display alert message with confirmation

       
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
