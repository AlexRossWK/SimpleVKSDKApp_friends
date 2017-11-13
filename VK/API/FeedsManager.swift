//
//  FeedsManager.swift
//  VK
//
//  Created by Алексей Россошанский on 26.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedsListManager {
    
    static func getListOfFeeds(successBlock: @escaping (_ feeds: [FeedsModel]) -> Void, failureBlock: @escaping (_ errorDesc: String) -> Void) {
        
        API_Wrapper.getNewsList(succBlock: { (response) in
            
            var feedsArray = [FeedsModel]()
            var profilesArray = [ProfilesModel]()
            var groupsArray = [GroupesModel]()
            let JSONResponse = JSON(response)
            
            let arrayOfJSONGroupsResponse = JSONResponse["response"]["groups"].arrayValue
            let arrayOfJSONProfilesResponse = JSONResponse["response"]["profiles"].arrayValue
            let arrayOfJSONFeedResponse = JSONResponse["response"]["items"].arrayValue

            
            for profile in arrayOfJSONProfilesResponse {
                
                let userID = profile["uid"].stringValue
                let name = profile["first_name"].stringValue
                let sName = profile["last_name"].stringValue
                let fullName = name + " " + sName
                let profilePhotoURL = profile["photo"].stringValue
                
            let newUser = ProfilesModel(userID: userID, fullName: fullName, profilePhotoURL: profilePhotoURL)
            profilesArray.append(newUser)
                
            }
            
            
            
            for group in arrayOfJSONGroupsResponse {
                
                let groupID = group["gid"].stringValue
                let groupName = group["name"].stringValue
                let groupPhoto = group["photo"].stringValue
                
            let newGroup = GroupesModel(groupID: groupID, groupName: groupName, groupPhoto: groupPhoto)
            groupsArray.append(newGroup)
            }
            
            
            
            
            for feed in arrayOfJSONFeedResponse {
                
                var typeOfFeed = feed["type"].stringValue
                
                switch typeOfFeed {
                case "post":
                    let sourceID = feed["source_id"].stringValue
                    let dateOfPublication = feed["date"].stringValue
                    let postID = feed["post_id"].stringValue
                    let textOfPost = feed["text"].stringValue
                    let photoURL = feed["attachment"]["photo"]["src_big"].stringValue
                    let photoWidth = feed["attachment"]["photo"]["width"].stringValue
                    let photoHeight = feed["attachment"]["photo"]["height"].stringValue
                    
                    let newFeed = FeedsModel(typeOfFeed: "post", sourceID: sourceID, dateOfPublication: dateOfPublication, postID: postID, textOfPost: textOfPost, photoURL: photoURL, photoWidth: photoWidth, photoHeight: photoHeight)
                    feedsArray.append(newFeed)
                case "photo":
                    let sourceID = feed["source_id"].stringValue
                    let dateOfPublication = feed["date"].stringValue
                    let photoURL = feed["photos"]["items"][0]["photo_604"].stringValue
                    let photoWidth = feed["photos"]["items"][0]["width"].stringValue
                    let photoHeight = feed["photos"]["items"][0]["height"].stringValue
                    let textUnderPhoto = feed["photos"]["items"][0]["text"].stringValue
                    
                let newFeed = FeedsModel(typeOfFeed: "photo", sourceID: sourceID, dateOfPublication: dateOfPublication, photoURL: photoURL, photoWidth: photoWidth, photoHeight: photoHeight, textUnderPhoto: textUnderPhoto)
                    feedsArray.append(newFeed)
                case "wall_photo":
                    let sourceID = feed["source_id"].stringValue
                    let dateOfPublication = feed["date"].stringValue
                    let photoURL = feed["photos"][0]["src_big"].stringValue
                    let photoWidth = feed["photos"][0]["width"].stringValue
                    let photoHeight = feed["photos"][0]["height"].stringValue
                    let textUnderPhoto = feed["photos"][0]["text"].stringValue
                    
                let newFeed = FeedsModel(typeOfFeed: "wall_photo", sourceID: sourceID, dateOfPublication: dateOfPublication, photoURL: photoURL, photoWidth: photoWidth, photoHeight: photoHeight, textUnderPhoto: textUnderPhoto)
                    feedsArray.append(newFeed)
                default:
                    break
                }
            }
                //Объединяем массивы
            
            for i in 0 ... feedsArray.count - 1 {
                //столько проверок чтобы не делать 3 раза вложенный цикл
                switch Int(feedsArray[i].sourceID)! {
                case let x where x < 0:
                    for j in 0 ... groupsArray.count - 1 {
                        if -Int(feedsArray[i].sourceID)! == Int(groupsArray[j].groupID)! {
                            feedsArray[i].groupName = groupsArray[j].groupName
                            feedsArray[i].groupPhoto = groupsArray[j].groupPhoto
                        }
        
                    }
                case let x where x > 0:
                        for j in 0 ... profilesArray.count - 1 {
                            if -Int(feedsArray[i].sourceID)! == Int(profilesArray[j].userID)! {
                                feedsArray[i].fullName = profilesArray[j].fullName
                                feedsArray[i].profilePhotoURL = profilesArray[j].profilePhotoURL
                            }
                            
                        }
                default:
                    break
                }
                
                
            }
                
            
            
       successBlock(feedsArray)
            
            
        }) { (errorDesc) in
            
            failureBlock(errorDesc)
        }
    }

}
