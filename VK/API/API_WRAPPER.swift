//
//  API_WRAPPER.swift
//  VK
//
//  Created by Алексей Россошанский on 13.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import Foundation


struct API_Wrapper {
  //Session
   static func getFriendsList(succBlock: @escaping (_ json: Any) -> Void, failBlock: @escaping (_ errorDesc: String) -> Void) -> URLSessionDataTask {
        
        let baseUrl = "https://api.vk.com/method/friends.get"
    

        let params: [String: Any] = [   "order": "name",
                                        "fields": "photo_50,city,domain,online,last_seen",
                                        "name_case": "nom",
                                        "access_token": "8ca78995e8fb51c464d233b48cefe08a72fe3a490b30fa0984f4ed2cf2091d15987fccda6e4f5d135c90a"]
    
        let request = API_Configurator.createRequest(withURL: baseUrl, andParams: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            API_Configurator.generalCompletionHandler(data, error, successBlock: succBlock, failureBlock: failBlock)
        }
        dataTask.resume()
        return dataTask
    }
    
}
