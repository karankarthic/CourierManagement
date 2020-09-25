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
   if let windowScene = scene as? UIWindowScene {
    let window = UIWindow(windowScene: windowScene)
   }

   // ZohoAuth Configuration

   let scope = ["ZohoCreator.meta.READ", "ZohoCreator.data.READ", "ZohoCreator.meta.CREATE", "ZohoCreator.data.CREATE", "aaaserver.profile.READ", "ZohoContacts.userphoto.READ", "ZohoContacts.contactapi.READ"]
   let clientID = "<Your Client ID>"
   let clientSecret = "<Your Client Secret>"
   let urlScheme = "<Your Url Scheme>"
   let accountsUrl = "https://accounts.zoho.com" // enter the accounts URL of your respective DC. For eg: EU users use 'https://accounts.zoho.eu'.
   ZohoAuth.initWithClientID(clientID, clientSecret: clientSecret, scope: scope, urlScheme: urlScheme, mainWindow: window, accountsURL: accountsUrl)

   // To verify if the app is already logged in

   ZohoAuth.getOauth2Token {
    (token, error) in
    if token == nil {
     // Not logged in
     self.showLoginScreen()
    } else {
     // App logged in already.
     // Ensure to use the following line of code in your iOS app before you utilize any of Creator SDK’s methods
     Creator.configure(delegate: self)
    }
   }
  }

 func scene(_ scene: UIScene, openURLContexts URLContexts: Set <UIOpenURLContext> ) {
  if let context = URLContexts.first {
   let _ = ZohoAuth.handleURL(context.url,
    sourceApplication: context.options.sourceApplication,
    annotation: context.options.annotation)
  }
 }
}

extension SceneDelegate: ZCCoreFrameworkDelegate {
  func oAuthToken(with completion: @escaping AccessTokenCompletion) {
   ZohoAuth.getOauth2Token {
    (token, error) in
    completion(token, error)
   }
  }
  func configuration() -> CreatorConfiguration {
   return CreatorConfiguration(creatorURL: "https://creator.zoho.com") // enter the creator URL of your respective data center (DC). For eg: EU users must use https://creator.zoho.eu
   }
  }
