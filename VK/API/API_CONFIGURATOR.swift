//
//  API_CONFIGURATOR.swift
//  VK
//
//  Created by Алексей Россошанский on 13.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import Foundation


class API_Configurator {
    
//Func for configure request
   static func createRequest(withURL url_: String, andParams params : [String: Any])-> URLRequest {
        
        var url = url_ + "?"
        
        for (key, value) in params {
            url = url + key + "=" + "\(value)" + "&"
        }
        
        url = String(url.characters.dropLast())
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        return request
        
    }
    
    
    
//General Completion Handler func
   static func generalCompletionHandler(_ data: Data?, _ reqError: Error?, successBlock: (_ json: Any) -> Void, failureBlock: (_ erroeDescription: String) -> Void) {
        
        if let error = reqError {
            switch error._code {
            case NSURLErrorFileDoesNotExist: failureBlock("File Doesn't exist")
            case NSURLErrorTimedOut: failureBlock("Time out")
            default : failureBlock("Another mistake")
            }
        }
        
        guard let data = data else {failureBlock("Data is nil"); return}
        
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
          successBlock(json)
        } catch {
            failureBlock("Serialization problem")
        }
    }
}


