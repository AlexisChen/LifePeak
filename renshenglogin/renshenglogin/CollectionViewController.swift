//
//  CollectionViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 3/20/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class CollectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var ref: DatabaseReference! = Database.database().reference()
    @IBOutlet weak var collectiontable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectiontable.delegate = self
        collectiontable.dataSource = self
        // Do any additional setup after loading the view.
        collectiontable.register(UINib(nibName: "CollectionCell", bundle: nil), forCellReuseIdentifier: "collectioncell")
        collectiontable.rowHeight = 320
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HomeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil);

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collectioncell", for: indexPath) as! CollectionCell
        
        if let userID = Auth.auth().currentUser?.uid{
            
            ref.child("Users").child(userID).observeSingleEvent(of: DataEventType.value) { (snapshot) in
                let value = snapshot.value as! NSDictionary
                cell.username.text = value["username"] as? String ?? ""
                cell.Bio.text = value["bio"] as? String ?? ""
            }
            
            ref.child("posts").child(userID).observe(DataEventType.childAdded, with: { (snapshot) in
            let value = snapshot.value as? [String:Any]
            let description = value!["description"] as? String ?? ""
            let picture = value?["picture"] as? String ?? ""
           
            if let decodedData = Data(base64Encoded: picture, options: .ignoreUnknownCharacters) {
                let image = UIImage(data: decodedData)
                cell.collectionimg.image = image
            }
            cell.collectioncontent.text = description
            
        }) { (error) in
            print(error.localizedDescription)
        }
        }
        return cell
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
