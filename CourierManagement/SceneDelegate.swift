//
//  SceneDelegate.swift
//  CourierManagement
//
//  Created by Karan Karthic on 25/09/20.
//  Copyright © 2020 Karan Karthic. All rights reserved.
//

import UIKit
import ZCCoreFramework


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let window = window else { return }
        LoginHandler.shared.configureCreatorClient(window: window)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set <UIOpenURLContext> ) {
        if let context = URLContexts.first {
            let _ = ZohoAuth.handleURL(context.url,
                                       sourceApplication: context.options.sourceApplication,
                                       annotation: context.options.annotation)
        }
    }
    
    
}


//extension SceneDelegate: ZCCoreFrameworkDelegate {
//  func oAuthToken(with completion: @escaping AccessTokenCompletion) {
//   ZohoAuth.getOauth2Token {
//    (token, error) in
//    completion(token, error)
//   }
//  }
//  func configuration() -> CreatorConfiguration {
//   return CreatorConfiguration(creatorURL: "https://creator.zoho.com") // enter the creator URL of your respective data center (DC). For eg: EU users must use https://creator.zoho.eu
//   }
//
//    func showLoginScreen() {
//     ZohoAuth.presentZohoSign( in: {
//      (token, error) in
//      if token != nil {
//       // success login
//       // Ensure to use the following line of code in your iOS app before you utilize any of Creator SDK’s methods
//       Creator.configure(delegate: self)
//        self.window?.rootViewController = MainViewController()
//      }
//     })
//    }
//
//    func logout() {
//     ZohoAuth.revokeAccessToken {
//      (error) in
//      if error == nil {
//       //Logout Successfully
//      }
//      else {
//       //Error Occurred
//      }
//     }
//    }
//  }
