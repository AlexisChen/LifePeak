//
//  NewPostViewController.swift
//  renshenglogin
//
//  Created by Cynthia Gao on 6/16/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import MobileCoreServices
import AVFoundation

class NewPostViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postMovieView: UIView!
    
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
    
                    //post image and video to storage
                func uploadImageToFirebaseStorage(data:NSData){
                        let storageRef = Storage.storage().reference().child("postImage.png")
                        if let uploadImageData = UIImagePNGRepresentation(self.postImageView.image!){
                            storageRef.putData(uploadImageData, metadata: nil, completion: {
                                (metadata, error) in
                                
                                if (error != nil) {
                                    print("error: \(String(describing: error))")
                                    return
                                }
                    
                func uploadMovieToFirebaseStorage(url:NSURL){
                    let storageRef = Storage.storage().reference().child("postVideo.mov")
                    let uploadMetadata = StorageMetadata()
                    uploadMetadata.contentType = "video/quicktime"
                    let uploadTask = storageRef.putFile(url, metadata: uploadMetadata) {(metadata,error) in
                        if (error != nil) {
                            print ("error: \(error)")
                            return
                            
                        }
                        }
                        
                    }

            storageRef.downloadURL {(url, error) in
                if let postUrl = url {
                    if let uid = Auth.auth().currentUser?.uid{
                        if let title = self.titleTextField.text {
                            if let description = self.descriptionTextField.text{
                                let postObject: Dictionary<String, Any> = [
                                    "uid" : uid,
                                    "title" : title,
                                    "description" : description,
                                    "postUrl" : postUrl,
                                ]
    Database.database().reference().child("posts").childByAutoId().setValue(postObject)

                print("Posted to Firebase.")
                }
            }
        }
                }
    
    func handleSelectPicture(){
        let picker = UIImagePickerController ()
        picker.delegate = self
        //picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
     func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        guard let mediaType: String = info[UIImagePickerControllerMediaType] as? String else {
            dismiss(animated: true, completion: nil)
            return
        }
        if mediaType == (kUTTypeImage as String){
            //selected an image
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage,let imageData = UIImageJPEGRepresentation(originalImage, 0.8){
                uploadImageToFirebaseStorage (data: imageData as NSData)
            }
            else if mediaType == (kUTTypeMovie as String){
            //selected a movie
                if let movieURL = info[UIImagePickerControllerMediaURL] as? NSURL {
                    uploadMovieToFirebaseStorage (url: movieURL)
                }
            }
        }
        var selectedImage = UIImage?.self
        var selectedMovie = UIView?.self
        self.postMovieView.isHidden = true
        //videoDuration.text = ""
        
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.self.postImageView.image = selectedImage
        } else if let selectedMoive = info[UIImagePickerControllerMediaType] as? UIView {
            self.postMovieView.isHidden = false
            //videoDuration.text = asset?.duration.localIdentifier
            initializeVideoPlayerWithVideo
        }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                print("canceled picker")
                dismiss (animated: true, completion: nil)
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

