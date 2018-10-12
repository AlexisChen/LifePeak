//
//  SearchViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 10/10/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth

struct post {
    var description :String = ""
    var picture: String=""
}

class SearchViewController: BackgroundImageViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var ref: DatabaseReference!
    var filteredPost :[post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //execute search with the text
        let searchText = searchBar.text!;
        if !searchText.isEmpty {
            //submit data to firebase
            ref = Database.database().reference()
            ref.child("posts").queryOrderedByKey().observe(DataEventType.value)
                { (snapshot) in
                    self.filteredPost.removeAll(keepingCapacity: false)
                print(snapshot.childrenCount) // I got the expected number of items
                let enumerator = snapshot.children
                while let postedUser = enumerator.nextObject() as? DataSnapshot {
                    let postEnum = postedUser.children
                    while let postDict = postEnum.nextObject() as? DataSnapshot {
                        if let userPost = postDict.value as? NSDictionary {
                            let postDescription = userPost["description"] as? String ?? ""
                            let postPicture = userPost["picture"] as? String ?? ""
                            if postDescription.lowercased().range(of:searchText.lowercased()) != nil {
                                self.filteredPost.append(post(description: postDescription, picture: postPicture))
                            }
                        }
                    }
                }
                self.searchResultTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPost.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! PostCollectionTableViewCell
        let cell_post :post=filteredPost[indexPath.row]
        cell.postDescription.text = cell_post.description
        if let imageData = Data(base64Encoded: cell_post.picture, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
            cell.postPicture.image = UIImage(data: imageData)!
        }
        return cell
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
//        searchBar.resignFirstResponder();
    }
}
