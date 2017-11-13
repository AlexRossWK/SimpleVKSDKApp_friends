//
//  FriendTableViewCell.swift
//  VK
//
//  Created by Алексей Россошанский on 19.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    

    @IBOutlet weak var imageOfFriend: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secNameLabel: UILabel!
    @IBOutlet weak var ImageOnlineOrNot: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
