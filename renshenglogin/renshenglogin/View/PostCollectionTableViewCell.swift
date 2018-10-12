//
//  PostCollectionTableViewCell.swift
//  renshenglogin
//
//  Created by Alexis Chen on 10/11/18.
//  Copyright © 2018 Alexis Chen. All rights reserved.
//

import UIKit

class PostCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var postDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
