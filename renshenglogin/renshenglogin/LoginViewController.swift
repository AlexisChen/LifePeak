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
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        userEmailTextField.resignFirstResponder()
        userPasswordTextField.resignFirstResponder()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text!;
        let userPassword = userPasswordTextField.text!;
        //check if fields are filled:
        if(userEmail.isEmpty || userPassword.isEmpty){
            displayAlertMessage(usermessage: "UserEmail and UserPassword cannot be empty");
            return
        }
        //when both fields are filled
        Auth.auth().signIn(withEmail: userEmail, password: userPassword, completion: {
            (user, error) in
            if user != nil {
                if (Auth.auth().currentUser?.isEmailVerified)! {
                    self.performSegue(withIdentifier: "LoginsuccessSegue", sender: nil)
                } else {
                    self.displayAlertMessage(usermessage: "Fuck! Told you to confirm!")
                }
            } else {
                if let myError = error?.localizedDescription{
                    self.displayAlertMessage(usermessage: myError);
                }else{
                    self.displayAlertMessage(usermessage: "This account haven't registered, please register first");
                }
            }
        })
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
    //prefill email and password
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: nil)
        if segue.destination is RegisterViewController {
            if let controller = segue.destination as? RegisterViewController {
                controller.prefilledEmail = String(userEmailTextField.text!);
                controller.prefilledPassword = String(userPasswordTextField.text!);
            }
        }
    }

}
