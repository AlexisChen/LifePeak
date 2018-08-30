//
//  NewPostViewController.swift
//  renshenglogin
//
//  Created by Cynthia Gao on 6/16/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class NewPostViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    

    @IBOutlet weak var addbutton: UIButton!
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var Add_Location: UIButton!
    @IBOutlet weak var Tag_friends: UIButton!
    @IBOutlet weak var add_to_collection: UIButton!
    
    @IBOutlet weak var content: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        content.tintColor = UIColor.lightGray
        
        let tapSingle=UITapGestureRecognizer(target:self,
                                             action:#selector(tapSingleDid))
        tapSingle.numberOfTapsRequired = 1
        self.postImageView.isUserInteractionEnabled = true
        self.postImageView.addGestureRecognizer(tapSingle)
    }
    
    @objc func tapSingleDid(_ ges:UITapGestureRecognizer){
         getpicture()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getphoto(_ sender: Any) {
         getpicture()
    }
    
    func getpicture(){
        let Sheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        weak var weakSelf = self
        
        let selectAction = UIAlertAction(title: "Select from Library", style: UIAlertActionStyle.default){ (action:UIAlertAction)in
            
            weakSelf?.initPhotoPicker()
        }
        
        let takeAction = UIAlertAction(title: "Take Photo", style: UIAlertActionStyle.default){ (action:UIAlertAction)in
            
            
            weakSelf?.initCameraPicker()
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){ (action:UIAlertAction)in
            
        }
        
        
        Sheet.addAction(selectAction)
        Sheet.addAction(takeAction)
        Sheet.addAction(cancelAction)
        
        self.present(Sheet, animated: true, completion: nil)
    }
    
    func initPhotoPicker(){
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    
    
    func initCameraPicker(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            
            print("Can not take picture")
            
        }
        
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage

        if picker.sourceType == .camera {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
        }
        
        postImageView.image = image
        addbutton.isHidden = true;
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        
        if error != nil {
            
            print("Save Failure")
            
            
        } else {
            
            print("Save Success")
            
            
        }
    }
    
    @IBAction func cancelpost(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func postTapped(_ sender: UIButton) {
    
//        if let uid = Auth.auth().currentUser?.uid{
//            if let title = titleTextField.text {
//                if let description = descriptionTextField.text{
//                    let postObject: Dictionary<String, Any> = [
//                        "uid" : uid,
//                        "title" : title,
//                        "description" : description
//                    ]
//                Database.database().reference().child("posts").childByAutoId().setValue(postObject)
//                
//                print("Posted to Firebase.")
//                }
//            }
//        }
        
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