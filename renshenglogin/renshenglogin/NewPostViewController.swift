//
//  NewPostViewController.swift
//  renshenglogin
//
//  Created by Cynthia Gao on 6/16/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import Firebase

class NewPostViewController: UIViewController {
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addLocation(_ sender: UIButton) {
    }
    @IBAction func postTapped(_ sender: UIButton) {
    
        if let uid = Auth.auth().currentUser?.uid{
            if let title = titleTextField.text {
                if let description = descriptionTextField.text{
                    let postObject: Dictionary<String, Any> = [
                        "uid" : uid,
                        "title" : title,
                        "description" : description
                    ]
                Database.database().reference().child("posts").childByAutoId().setValue(postObject)
                }
            }
        }
        
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
