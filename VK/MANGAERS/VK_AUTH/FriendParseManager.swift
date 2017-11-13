//
//  FriendParseManager.swift
//  VK
//
//  Created by Алексей Россошанский on 14.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import Foundation
import SwiftyJSON

class FriendsParseManager {
    
    static func getFriends(success: @escaping (_ photos: [FriendModel] ) -> Void, failure: @escaping (_ errorDescription: String) -> Void) {
        
        //В этом менеджере мы отправляем запрос, получаем данные в JSON формате и переводим их в массив объектов
        _ = API_WRAPPER.getFriendsList(success1: { (response) in
            
            var photosArray = [FriendModel]()
            let jsonResponse = JSON(response)
            
            let arrayOfJSON = jsonResponse["response"].arrayValue
            
            for photo in arrayOfJSON {
                
                let owner = photo["uid"].stringValue
                let secret = photo["secret"].stringValue
                let server = photo["server"].stringValue
                let photoId = photo["id"].stringValue
                let farm = photo["farm"].intValue
                let title = photo["title"].string
                
                let newPhoto = PhotoModel(owner: owner, secret: secret, server: server, photoId: photoId, farm: farm, title: title)
                
                newPhoto.url = API_Configurator.createImgURL(object: newPhoto)
                
                photosArray.append(newPhoto)
                
            }
            
            success(photosArray)
            
            
        }) { (errorDescrption) in
            
            //если API_Configurator обработал запрос и решил, что там ошибка - выозвется этот блок, который в свою очередь вызывает failure блок, описанный в контроллере
            failure(errorDescrption)
            
        }
        
    }
    
}
