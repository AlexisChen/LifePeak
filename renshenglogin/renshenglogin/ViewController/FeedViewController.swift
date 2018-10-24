//
//  FeedViewController.swift
//  renshenglogin
//
//  Created by Alexis Chen on 10/11/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseCore

class FeedViewController: UITableViewController {

    var followingUsers: [String] = []
    var feedPosts: [UserPost] = []
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 200;
        // fetch following data
        ref = Database.database().reference()
        if let uid = Auth.auth().currentUser?.uid {
            ref.child("Users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                if let userInfo = snapshot.value as? NSDictionary {
                    if let userFollowing = userInfo["following"] as? NSDictionary {
                        //clear current following content
                        if !self.followingUsers.isEmpty {
                            self.followingUsers.removeAll()
                        }
                        for (followingUser, _) in userFollowing {
                            self.followingUsers.append(followingUser as! String)
                        }
                        self.fetchPostData()
                    }
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedPosts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! PostCollectionTableViewCell
//        let cell_post = feedPosts[indexPath.row]
//        let tempDescription = UILabel(frame: CGRect(0, 0, 200, 21))
//        
//        cell.postDescription.text = cell_post.description
//        if let imageData = Data(base64Encoded: cell_post.picture, options: Data.Base64DecodingOptions.ignoreUnknownCharacters) {
//            let tempImage = UIImageView(image: UIImage(data: imageData))
//        }
        return cell
    }
    
    func fetchPostData() {
        //fetch and posts data for following users
        for followingUser in followingUsers {
            ref.child("posts").child(followingUser).observe(DataEventType.value) { (snapshot) in
                let postEnum = snapshot.children
                while let tempPost = postEnum.nextObject() as? DataSnapshot {
                    if let userPost = tempPost.value as? NSDictionary {
                        let description = userPost["description"] as? String ?? ""
                        let picture = userPost["picture"] as? String ?? ""
                        let time = userPost["time"] as? String ?? ""
                        self.feedPosts.append(UserPost(description:description, picture:picture, time:time))
                    }
                }
                //sort feed posts
                self.feedPosts.sort { (p1, p2) -> Bool in
                    return p1.time < p2.time
                }
                self.tableView.reloadData()
            }
        }
    }
}
