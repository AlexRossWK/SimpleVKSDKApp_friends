//
//  File.swift
//  VK
//
//  Created by Алексей Россошанский on 08.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import VK_ios_sdk

class VK_AUTH_Manager: NSObject{
    
    static let permissions = ["friends", "photos", "status","messages", "offline", "groups", "email", "wall"]
    
    var delegate: AuthorizationDelegate!
    weak var vc: UIViewController!
    var sdkInstance: VKSdk!
    
    func checkVKAuthorization(withDelegate delegate: AuthorizationDelegate, controller: UIViewController){
        
        sdkInstance = VKSdk.initialize(withAppId: "6211869")
        sdkInstance.register(self)
        sdkInstance.uiDelegate = self
        self.delegate = delegate
        self.vc = controller
        
        //        VKSdk.forceLogout()  - for logging out
        VKSdk.wakeUpSession(VK_AUTH_Manager.permissions) { (state, error) in
            
            if state == .authorized {
                
                delegate.authorizationCompleted()
                
            } else {
                
                VKSdk.authorize(VK_AUTH_Manager.permissions)
            }
        }
    }
}


//AUTHORIZATION
extension VK_AUTH_Manager: VKSdkUIDelegate, VKSdkDelegate {
    
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        DispatchQueue.main.async { [weak self] in
            self?.vc.present(controller, animated: true)
            
        }
    }
    
    
    func vkSdkUserAuthorizationFailed() {
        
        delegate.authorizationDidFailed()
    }
    
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
        print("CAptcha")
    }
    
    //When authorization checked
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        
        if let token = result.token {
            
            UserDefaults.standard.set(token.accessToken, forKey: Const.AppDefaultsKeys.accessToken)
            UserDefaults.standard.synchronize()
            delegate.authorizationCompleted()
            
        } else {
            
            
            delegate.authorizationDidFailed()
            
        }
        
    }
}
