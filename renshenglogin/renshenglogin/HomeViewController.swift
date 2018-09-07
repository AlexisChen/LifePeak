//
//  HomeViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 2/11/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore

class HomeViewController: BackgroundImageViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    
    @IBOutlet weak var changebackground: UIButton!
    @IBOutlet weak var backgroundimg: UIImageView!
    @IBOutlet weak var changefile: UIButton!
    @IBOutlet weak var fileimg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var bio: UILabel!
    
    var tappedbutton : Int = 0;
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let uid = Auth.auth().currentUser?.uid{
            ref.child("Users").child(uid).observeSingleEvent(of: DataEventType.value) { (snapshot) in
                let value = snapshot.value as! NSDictionary
                self.username.text = value["username"] as? String ?? ""
                self.bio.text = value["bio"] as? String ?? ""
            }
        }
        backgroundimg.addSubview(fileimg)
        fileimg.layer.borderColor = UIColor.gray.cgColor
        fileimg.layer.borderWidth = 0.5
        
        self.view.bringSubview(toFront: changebackground)
        self.view.bringSubview(toFront: changefile)
        
        let tapSingleBackground=UITapGestureRecognizer(target:self,
                                             action:#selector(backgroundTapSingleDid))
        let tapSingleFile=UITapGestureRecognizer(target:self,
                                                       action:#selector(fileTapSingleDid))
        tapSingleBackground.numberOfTapsRequired = 1
        tapSingleFile.numberOfTapsRequired = 1
        self.backgroundimg.isUserInteractionEnabled = true
        self.backgroundimg.addGestureRecognizer(tapSingleBackground)
        self.fileimg.isUserInteractionEnabled = true
        self.fileimg.addGestureRecognizer(tapSingleFile)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func fileTapSingleDid(_ ges:UITapGestureRecognizer){
        getpicture()
        tappedbutton = 2
    }

    @objc func backgroundTapSingleDid(_ ges:UITapGestureRecognizer){
        getpicture()
        tappedbutton = 1
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changebkg(_ sender: Any) {
        getpicture()
        tappedbutton = 1
    }
    
    @IBAction func changefilepic(_ sender: Any) {
        getpicture()
        tappedbutton = 2
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
        if(tappedbutton == 1){
        backgroundimg.image = image
        changebackground.isHidden = true
        }
        if(tappedbutton == 2){
        fileimg.image = image
        changefile.isHidden = true
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject) {
        
        if error != nil {
            
            print("Save Failure")
            
            
        } else {
            
            print("Save Success")
            
            
        }
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
