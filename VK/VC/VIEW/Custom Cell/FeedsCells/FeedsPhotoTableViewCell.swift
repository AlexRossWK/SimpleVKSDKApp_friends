//
//  FeedsPhotoTableViewCell.swift
//  VK
//
//  Created by Алексей Россошанский on 27.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import UIKit
import Kingfisher

class FeedsPhotoTableViewCell: UITableViewCell {

    var feedsArray = [FeedsModel]()

    @IBOutlet weak var imageOfGroupOrUser: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postPhoto: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    
    
    func sendArrayOfPostsPhotos(withModel model: [FeedsModel], andTableView tableView: UITableView) {
        
        feedsArray = model
        
    }
    
    
    
    func postPhotoCellConfigure(andTableView tableView: UITableView, andIndexPath indexPath: IndexPath) {
        
         if (feedsArray[indexPath.row].groupName == nil) {
        imageOfGroupOrUser.kf.setImage(with: URL(string: feedsArray[indexPath.row].profilePhotoURL!))
        nameLabel.text = feedsArray[indexPath.row].fullName
            } else {
            imageOfGroupOrUser.kf.setImage(with: URL(string: feedsArray[indexPath.row].groupPhoto!))
            nameLabel.text = feedsArray[indexPath.row].groupName!
        }
        timeLabel.text = feedsArray[indexPath.row].dateOfPublication
        postPhoto.kf.setImage(with: URL(string: feedsArray[indexPath.row].photoURL!))

        
    }
    

    
    
}
