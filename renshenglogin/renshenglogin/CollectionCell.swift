//
//  CollectionCell.swift
//  renshenglogin
//
//  Created by WJL on 8/30/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {
    @IBOutlet weak var collectionimg: UIImageView!
    @IBOutlet weak var collectioncontent: UITextView!
    @IBOutlet weak var username: UITextView!
    @IBOutlet weak var userimg: UIImageView!
    @IBOutlet weak var Bio: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
