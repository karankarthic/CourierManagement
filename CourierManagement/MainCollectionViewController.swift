//
//  MainCollectionViewController.swift
//  CourierManagement
//
//  Created by Karan Karthic on 07/10/20.
//  Copyright © 2020 Karan Karthic. All rights reserved.
//

import UIKit
import ZCCoreFramework
import ZCUIFramework

class MainCollectionViewController: UIViewController {
    
    var tiles: [Component] = []
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = UIColor.init(red: 34/255, green: 36/255, blue: 38/255, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension MainCollectionViewController{
    
    @objc private func logout() {
        ZohoAuth.revokeAccessToken {
            (error) in
            if error == nil {
                //Logout Successfully
            }
            else {
                //Error Occurred
            }
        }
    }
}


extension MainCollectionViewController {
    private func setupUI() {

        self.view.backgroundColor = UIColor.init(red: 34/255, green: 36/255, blue: 38/255, alpha: 1)
        self.navigationController?.navigationBar.topItem?.title = "Courier Management"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Logout", style: .plain, target: self, action: #selector(self.logout))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidthHeightConstant: CGFloat = 120
        
        layout.sectionInset = UIEdgeInsets(top: 40,
                                           left: 40,
                                           bottom: 40,
                                           right: 40)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 30
        layout.itemSize = CGSize(width: cellWidthHeightConstant, height: cellWidthHeightConstant)
        
        return layout
    }
    
    private func getComponentViewController(for index:Int){
        
        let component = self.tiles[index]
        
        let vc:UIViewController
        
        switch component.type {
            
        case .form:
            vc = ZCUIService.getViewController(forForm: ComponentDetail.init(componentLinkName: component.componentLinkName))
        case .report:
             vc = ZCUIService.getViewController(forReport: ComponentDetail.init(componentLinkName: component.componentLinkName))
        case .calendar:
            return
        case .page:
             vc = ZCUIService.getViewController(forPage: ComponentDetail.init(componentLinkName: component.componentLinkName))
            
        case .htmlPage:
            return
        case .summary:
            return
        case .grid:
            return
        case .spreadSheet:
            return
        case .pivotChart:
            return
        case .pivotTable:
            return
        case .map:
            return
        case .timeLine:
            return
        case .kanban:
            return
        case .approvalPending:
            return
        case .approvalCompleted:
            return
        case .unknown:
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.titleLabel.text = tiles[indexPath.row].componentLinkName
        cell.imgView.image = UIImage.init(named: tiles[indexPath.row].componentLinkName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.getComponentViewController(for:indexPath.row)
    }
    
}
class MainCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor.init(red: 63/255, green: 68/255, blue: 74/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imgView : UIImageView = {
        let imgView = UIImageView()
        imgView.sizeToFit()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
}

extension MainCollectionViewCell {
    private func setupUI() {
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(titleLabel)
        roundedBackgroundView.addSubview(imgView)
//        imgView.image = UIImage.init(named: "Screenshot 2020-09-23 at 1.43.49 PM")
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            roundedBackgroundView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            roundedBackgroundView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            titleLabel.centerXAnchor.constraint(equalTo: roundedBackgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: roundedBackgroundView.centerYAnchor,constant: 70),
            imgView.centerXAnchor.constraint(equalTo: roundedBackgroundView.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: roundedBackgroundView.centerYAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 50),
            imgView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}


