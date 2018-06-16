//
//  LoginViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 1/27/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        //check if fields are filled:
        if(userEmail == "" || userPassword == ""){
            displayAlertMessage(usermessage: "UserEmail and UserPassword cannot be empty");
        }
        //when both fields are filled
        Auth.auth().signIn(withEmail: userEmail!, password: userPassword!, completion: {
            (user, error) in
            if(user != nil){
                //sign in successful
                
            }else{
                if let myError = error?.localizedDescription{
                    self.displayAlertMessage(usermessage: myError);
                }else{
                    self.displayAlertMessage(usermessage: "This account haven't registered, please register first");
                }
            }
        })
        /*
        //using local storage
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail");
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");
        if(userEmailStored == userEmail && userPasswordStored == userPassword){
            UserDefaults.standard.set(true, forKey: "isUserLoggedIn");
            UserDefaults.standard.synchronize();
            self.dismiss(animated: true, completion: nil);
        }
         */
    }
    //alert window
    func displayAlertMessage(usermessage: String)
    {
        print(usermessage);
        let myAlert = UIAlertController(title: "Oopsie", message: usermessage, preferredStyle: UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"ok", style: UIAlertActionStyle.default, handler:nil);
        myAlert.addAction(okAction);
        self.present(myAlert, animated: true, completion: nil);
    }
}
