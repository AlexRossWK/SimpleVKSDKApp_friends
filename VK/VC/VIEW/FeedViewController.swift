//
//  FeedViewController.swift
//  VK
//
//  Created by Алексей Россошанский on 08.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.


import UIKit
import SwiftyJSON
import Kingfisher


class FeedViewController: UIViewController {
    
    
    
    @IBOutlet weak var feedTableView: UITableView!
    
    
    


    var feedsArray = [FeedsModel]()
    var profilesArray = [ProfilesModel]()
    var groupsArray = [GroupesModel]()
    
}

//MARK: View Loads
extension FeedViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
      getFeedsRequest()
        
        self.feedTableView.register(UINib(nibName: "FeedsTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedsTableViewCell")
        self.feedTableView.register(UINib(nibName: "FeedsPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedsPhotoTableViewCell")


}
}


//MARK: Feeds Table View
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsArray.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch feedsArray[indexPath.row].typeOfFeed {
        case "post":
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as! FeedsTableViewCell
            cell.sendArrayOfPosts(withModel: feedsArray, andTableView: feedTableView)
            cell.postCellConfigure(andTableView: feedTableView, andIndexPath: indexPath)
            return cell
        case "photo":
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsPhotoTableViewCell", for: indexPath) as! FeedsPhotoTableViewCell
            cell.sendArrayOfPostsPhotos(withModel: feedsArray, andTableView: feedTableView)
            cell.postPhotoCellConfigure(andTableView: feedTableView, andIndexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsTableViewCell", for: indexPath) as! FeedsTableViewCell
            cell.sendArrayOfPosts(withModel: feedsArray, andTableView: feedTableView)
            cell.postCellConfigure(andTableView: feedTableView, andIndexPath: indexPath)
            return cell
        }
        
   
    }
 
    
}





    //MARK: Request
    
extension FeedViewController {
    
    func getFeedsRequest(){
        FeedsListManager.getListOfFeeds(successBlock: { [weak self] (feeds) in
            
            DispatchQueue.main.async {
                self?.feedsArray.removeAll()
                self?.feedsArray.append(contentsOf: feeds)
                self?.feedTableView.reloadData()
                
            }
            
            
            
            
        }) { (errorDesc) in
            print(errorDesc)
        }
        

    }
}
            







