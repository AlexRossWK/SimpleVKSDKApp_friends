//
//  AuthorizationDelegate.swift
//  VK
//
//  Created by Алексей Россошанский on 08.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//



protocol AuthorizationDelegate {
    
    func authorizationDidFailed()
    func authorizationCompleted()
    
}
