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
        loginButton.layer.cornerRadius = 70
        loginButton.setTitle("SignIn", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .ultraLight)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1)
        loginButton.addTarget(self, action: #selector(showLogin), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        return loginButton
    }()
    
    lazy var circularView = CircularProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginView()
    }
    
    func setupLoginView(){
        
        self.view.backgroundColor = UIColor.init(red: 110/255, green: 110/255, blue: 110/255, alpha: 1)
        self.view.addSubview(circularView)
        self.view.addSubview(loginButton)

        circularView.center = view.center
        NSLayoutConstraint.activate([
                                      loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                      loginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                      loginButton.heightAnchor.constraint(equalToConstant: 140),
                                      loginButton.widthAnchor.constraint(equalToConstant: 140)
        ])
        circularView.alpha = 0

    }
    
    @objc private func showLogin(){
        
        circularView.alpha = 1
        LoginHandler.shared.login()
        circularView.progressAnimation(duration: 50)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+50) {
            self.circularView.alpha = 0
        }
        
    }
  
}


class CircularProgressView: UIView {
    
    private var circleLayer = CAShapeLayer()
    
    private var progressLayer = CAShapeLayer()
    var circularView: CircularProgressView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }
    func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: 80, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 10.0
        circleLayer.strokeColor = UIColor.black.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 5.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1).cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
