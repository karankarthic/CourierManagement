//
//  LoginHandler.swift
//  CourierManagement
//
//  Created by Karan Karthic on 08/10/20.
//  Copyright © 2020 Karan Karthic. All rights reserved.
//

import UIKit
import ZCCoreFramework

class LoginHandler {
    
    static var shared = LoginHandler()
    
    private var application = Application(appOwnerName: "vigneshkumargt0", appLinkName: "courier-management")
    
    var window:UIWindow?
    
    private var mainVc : MainCollectionViewController?
    
    private init(){ }
    
    
    func configureCreatorClient(window: UIWindow){
        
        self.window = window
        
        if ZohoAuth.isUserSignedIn(){
            self.setUpViewcontroller()
            
        }else{
            self.window?.rootViewController = ViewController()
        }
        
        let scope = ["ZohoCreator.meta.READ", "ZohoCreator.data.READ", "ZohoCreator.meta.CREATE", "ZohoCreator.data.CREATE", "aaaserver.profile.READ", "ZohoContacts.userphoto.READ", "ZohoContacts.contactapi.READ"]
        let clientID = "1000.S45UAZ5HE09NQU6A9CPKIY3JDNAT0Z"
        let clientSecret = "72ac3839c8b8c0af6dbe60b4f220d1752de8b52d76"
        let urlScheme = "couriermanagement://"
        let accountsUrl = "https://accounts.zoho.com" // enter the accounts URL of your respective DC. For eg: EU users use 'https://accounts.zoho.eu'.
        
        ZohoAuth.initWithClientID(clientID, clientSecret: clientSecret, scope: scope, urlScheme: urlScheme, mainWindow: window, accountsURL: accountsUrl)
    }
    
    func logOut(){
        guard let window = self.window else { return }
        DispatchQueue.main.async {
            window.rootViewController = ViewController()
        }
    }
    
    func login(){
        ZohoAuth.getOauth2Token {
            (token, error) in
            if token == nil {
                // Not logged in
                
                self.showLoginScreen()
                
            } else {
                // App logged in already.
                // Ensure to use the following line of code in your iOS app before you utilize any of Creator SDK’s methods
                Creator.configure(delegate: self)
                
                self.setUpViewcontroller()
                
            }
        }
        
    }
    
    private func showLoginScreen(){
        
        ZohoAuth.presentZohoSign( in: {
            (token, error) in
            if token != nil {
                // success login
                // Ensure to use the following line of code in your iOS app before you utilize any of Creator SDK’s methods
                Creator.configure(delegate: self)
                self.setUpViewcontroller()
                
            }
            
            if error != nil{
                guard let window = self.window else { return }
                
                guard let vc = window.rootViewController as? ViewController else{return}
                DispatchQueue.main.async {
                    vc.circularView.alpha = 0
                }
            }
        })
        
        
    }
    
   private func setUpViewcontroller(){
            
        mainVc = MainCollectionViewController()
        ZCAPIService.fetchSectionList(for: application) { (result) in
            switch result
            {
            case .success(let sectionlist):
                let components = self.getComponents(sectionlist.sections)
                self.mainVc?.tiles = components
                
               
            case .failure(_):
                print("error")
                self.mainVc?.tiles = []
                
            }
            guard let mainVc = self.mainVc else{return}
            DispatchQueue.main.async {
                let navVc = UINavigationController(rootViewController: mainVc)
                self.window?.rootViewController = navVc
            }
             
         }
       
    }
    
    private func getComponents(_ sections:[Section])->[Component]{
        var components:[Component] = []
        
        for section in sections{
            for component in section.components {
                components.append(component)
            }
        }
        
        return components
        
    }
    
    
    
}

extension LoginHandler: ZCCoreFrameworkDelegate{
    
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
