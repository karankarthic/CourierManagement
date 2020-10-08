//
//  ViewController.swift
//  CourierManagement
//
//  Created by Karan Karthic on 25/09/20.
//  Copyright © 2020 Karan Karthic. All rights reserved.
//

import UIKit
import ZCCoreFramework

class ViewController: UIViewController{
    
    lazy var loginButton :UIButton = {
        var loginButton = UIButton()
        loginButton.layer.cornerRadius = 50
        loginButton.setTitle("SignIn", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .ultraLight)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        loginButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setUpView()
        setupLoginView()
    }
    
    func setupLoginView(){
        
        self.view.backgroundColor = UIColor.init(red: 110/255, green: 110/255, blue: 110/255, alpha: 1)
        self.view.addSubview(loginButton)

        NSLayoutConstraint.activate([
                                      loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                      loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                      loginButton.heightAnchor.constraint(equalToConstant: 100),
                                      loginButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        

    }
    
    
    @objc private func showLogin(){
        
        LoginHandler.shared.login()
        
    }
    
    
}
