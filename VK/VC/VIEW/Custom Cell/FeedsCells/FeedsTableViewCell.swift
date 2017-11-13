//
//  FeedsTableViewCell.swift
//  VK
//
//  Created by Алексей Россошанский on 27.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import UIKit
import Kingfisher

class FeedsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupImageView: UIImageView!
    
    @IBOutlet weak var nameOfGroup: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var imageOfPost: UIImageView!
    
    
    var feedsArray = [FeedsModel]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    func sendArrayOfPosts(withModel model: [FeedsModel], andTableView tableView: UITableView) {
        
        feedsArray = model
    }
    
    
    
    func postCellConfigure(andTableView tableView: UITableView, andIndexPath indexPath: IndexPath) {
        
        if (feedsArray[indexPath.row].groupName == nil) {
            groupImageView.kf.setImage(with: URL(string: feedsArray[indexPath.row].profilePhotoURL ?? ""))
            nameOfGroup.text = feedsArray[indexPath.row].fullName
        } else {
        groupImageView.kf.setImage(with: URL(string: feedsArray[indexPath.row].groupPhoto!))
        nameOfGroup.text = feedsArray[indexPath.row].groupName!
        }
        timeLabel.text = feedsArray[indexPath.row].dateOfPublication
        postLabel.text = feedsArray[indexPath.row].textOfPost
        imageOfPost.kf.setImage(with: URL(string: feedsArray[indexPath.row].photoURL!))
        
    }
    

    
   
    
    
    
}

