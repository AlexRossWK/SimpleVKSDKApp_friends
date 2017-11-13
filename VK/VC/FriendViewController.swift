//
//  FriendViewController.swift
//  VK
//
//  Created by Алексей Россошанский on 14.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher

class FriendViewController: UIViewController {
    
    var friendsArray = [FriendModel]()
    var peopleGroupedByFirstLetterInSName = [String.Element: [FriendModel]]()
    var arrayOfFirstLetters = [String.Element]()
    var sortedDict = [(key: String.Element, value: [FriendModel])]()
    
    
    var friendsOnlineArray = [FriendModel]()
    var peopleGroupedByFirstLetterInSNameONLINE = [String.Element: [FriendModel]]()
    var arrayOfFirstLettersONLINE = [String.Element]()
    var sortedDictONLINE = [(key: String.Element, value: [FriendModel])]()
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    var foundData = [FriendModel]()
    
    @IBOutlet weak var friendsTableView: UITableView!
    @IBOutlet weak var switchSegmentOutlet: UISegmentedControl!
    
    var isReloaded = false
    
    @IBAction func switchSegmentAction(_ sender: UISegmentedControl) {
        
        friendsTableView.reloadData()
        
        
    }
}


//MARK: View Loads
extension FriendViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friendsTableView.delegate = self
        self.friendsTableView.dataSource = self
        self.searchBar.delegate = self
        getFriendsRequest()
        
        switchSegmentOutlet.tintColor = UIColor.lightGray
        
        
    }
    
    
}


//MARK: search bar extension

extension FriendViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        foundData = friendsArray.filter({
            //lowercased Characters!
            (model: FriendModel) -> Bool in
            return (model.sName.lowercased().range(of: searchBar.text!.lowercased()) != nil)
            
        })
        
        
        if searchBar.text != "" {
            isSearching = true
            friendsTableView.reloadData()
            
        }else{
            isSearching = false
            friendsTableView.reloadData()
        }
        
    }
    
}




//Mark: TableView extension

extension FriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    //Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        //For all friends COUNTS
        
        peopleGroupedByFirstLetterInSName = Dictionary(grouping: friendsArray) {
            $0.sName.first!}
        
        arrayOfFirstLetters = Array(peopleGroupedByFirstLetterInSName.keys.sorted())
        
        sortedDict = peopleGroupedByFirstLetterInSName.sorted{$0.key < $1.key}
        
        //for friends who online Counts
        peopleGroupedByFirstLetterInSNameONLINE = Dictionary(grouping: friendsOnlineArray) {
            $0.sName.first!}
        
        arrayOfFirstLettersONLINE = Array(peopleGroupedByFirstLetterInSNameONLINE.keys.sorted())
        
        sortedDictONLINE = peopleGroupedByFirstLetterInSNameONLINE.sorted{$0.key < $1.key}
        //End for friend who online Counts
        
        
        if isSearching {
            return 1
        } else {
            
            switch switchSegmentOutlet.selectedSegmentIndex {
            case 0:
                
                return peopleGroupedByFirstLetterInSName.count
                
            default:
                return peopleGroupedByFirstLetterInSNameONLINE.count
            }
            
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if isSearching { return "" } else { return String(Array(peopleGroupedByFirstLetterInSName.keys.sorted())[section]) }
        
    }
    
    
    //Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        //search bar
        if isSearching {
            return foundData.count
        } else {
            
            switch switchSegmentOutlet.selectedSegmentIndex {
            case 0:
                
                return sortedDict[section].value.count
                
            default:
                return sortedDictONLINE[section].value.count
            }
            
        }
        return friendsArray.count
    }
    
    //Cell for row with segment control
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //search bar
        if isSearching {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
            
            cell.imageOfFriend.kf.setImage(with: URL(string: foundData[indexPath.row].photoURL))
            cell.imageOfFriend.layer.cornerRadius = cell.imageOfFriend.frame.size.width / 2
            cell.imageOfFriend.clipsToBounds = true
            
            cell.nameLabel.text = foundData[indexPath.row].fName
            cell.secNameLabel.text = foundData[indexPath.row].sName
            
            if foundData[indexPath.row].online == 1 { cell.ImageOnlineOrNot.image  = #imageLiteral(resourceName: "compOnline.png") }
            
            return cell
            
        }
        
        
        switch switchSegmentOutlet.selectedSegmentIndex {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
            
            
            
            let zhnachenie = sortedDict[indexPath.section].value[indexPath.row]
            
            cell.imageOfFriend.kf.setImage(with: URL(string: zhnachenie.photoURL))
            cell.imageOfFriend.layer.cornerRadius = cell.imageOfFriend.frame.size.width / 2
            cell.imageOfFriend.clipsToBounds = true
            
            cell.nameLabel.text = zhnachenie.fName
            cell.secNameLabel.text = zhnachenie.sName
            
            if zhnachenie.online == 1 { cell.ImageOnlineOrNot.image  = #imageLiteral(resourceName: "compOnline.png") } else {cell.ImageOnlineOrNot.image = nil}
            
            
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! FriendTableViewCell
            
            let zhnachenie = sortedDictONLINE[indexPath.section].value[indexPath.row]
            
            cell.imageOfFriend.kf.setImage(with: URL(string: zhnachenie.photoURL))
            cell.imageOfFriend.layer.cornerRadius = cell.imageOfFriend.frame.size.width / 2
            cell.imageOfFriend.clipsToBounds = true
            
            cell.nameLabel.text = zhnachenie.fName
            cell.secNameLabel.text = zhnachenie.sName
            
            if zhnachenie.online == 1 { cell.ImageOnlineOrNot.image  = #imageLiteral(resourceName: "compOnline.png") } else {cell.ImageOnlineOrNot.image = nil}
            
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    
}



//MARK: Request

extension FriendViewController {
    
    func getFriendsRequest(){
        
        FriendsListManager.getListOfFriendss(succBlock: { [weak self] (friends) in
            
            DispatchQueue.main.async{
                self?.friendsArray.append(contentsOf: friends)
                self?.friendsTableView.reloadData()
                
                //Who is online
                self?.friendsOnlineArray = (self?.friendsArray.filter{$0.online == 1})!
                //Segments titles
                self?.switchSegmentOutlet.setTitle("\(self!.friendsArray.count) друзей", forSegmentAt: 0)
                self?.switchSegmentOutlet.setTitle("\(self!.friendsOnlineArray.count) онлайн", forSegmentAt: 1)
                
            }
            
            
        }) { (errorDesc) in
            print(errorDesc)
        }
        
        
    }
    
}




