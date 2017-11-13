//
//  FriendsManager.swift
//  VK
//
//  Created by Алексей Россошанский on 18.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import Foundation
import SwiftyJSON

class FriendsListManager{
    
    static func getListOfFriendss(succBlock: @escaping (_ friends: [FriendModel]) -> Void, failBlock: @escaping (_ errorDesc: String) -> Void) {
        
        _ = API_Wrapper.getFriendsList(succBlock: { (response) in
            
            var friendArray = [FriendModel]()
            
            let jsonResponse = JSON(response)
        
            let arrayOfJsonFriend = jsonResponse["response"].arrayValue
            
            for friend in arrayOfJsonFriend {
                
                let uid = friend["id"].intValue
                let fName = friend["first_name"].stringValue
                let sName = friend["last_name"].stringValue
                let photoURL = friend["photo_50"].stringValue
                let online = friend["online"].intValue
                let time = friend["last_seen"]["time"].stringValue
                let platform = friend["last_seen"]["platform"].stringValue
                
                let addFriend = FriendModel(uid: uid, fName: fName, sName: sName, photoURL: photoURL, online: online, time: time, platform: platform)
                friendArray.append(addFriend)
                
            }
            
            succBlock(friendArray)
       
        }) { (errorDesc) in
            
            failBlock(errorDesc)
            
        }
        
    }

}
