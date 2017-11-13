//
//  Models.swift
//  VK
//
//  Created by Алексей Россошанский on 13.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import Foundation


class FriendModel {
    
    let uid: Int
    let fName: String
    let sName: String
    let photoURL: String
    let online: Int
    let time: String
    let platform: String
    
    init(uid: Int, fName: String, sName: String, photoURL: String, online: Int, time: String, platform: String) {
        
        self.uid = uid
        self.fName = fName
        self.sName = sName
        self.photoURL = photoURL
        self.time = time
        self.online = online
        self.platform = platform
    
    
}
}


extension FriendModel  {
    var titleFirstLetter: String {
        return String(self.sName[self.sName.startIndex]).uppercased()
    }
}





