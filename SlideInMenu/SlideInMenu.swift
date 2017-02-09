//
//  SlideMenu.swift
//  SlideInMenu
//
//  Created by hongbozheng on 2/8/17.
//  Copyright © 2017 fiu. All rights reserved.
//

import UIKit

 class Setting:NSObject{
    let name: SettingName
    let imageName:String
    
    init(name:SettingName,imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}

 enum SettingName:String{
    case Cancel = "Cancel"
    case Settings = "Settings"
    case TermsPrivacy = "Terms & privacy policy"
    case SendFeedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
}

class SlideInMenu: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
   private lazy var maskView :UIButton = {
          let tmpV = UIButton()
            tmpV.backgroundColor = UIColor(white: 0, alpha: 0.5)
            tmpV.alpha = 0
            tmpV.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return tmpV
    }()
    
  private  lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       let tmpCV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tmpCV.backgroundColor = UIColor.white
        return tmpCV
    }()
   private let cellID = "cellID"
   private let cellHeight:CGFloat = 50
    
    private lazy var settings:[Setting] = {
        let cancel = Setting(name: .Cancel, imageName: "cancel")
        
        return [Setting(name: .Settings, imageName: "settings"), Setting(name: .TermsPrivacy, imageName: "privacy"), Setting(name: .SendFeedback, imageName: "feedback"), Setting(name: .Help, imageName: "help"), Setting(name: .SwitchAccount, imageName: "switch_account"), cancel]
    }()
    
    var homeVC: ViewController?
  override  init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
    func showSettings()  {
        if let window = UIApplication.shared.keyWindow {
            maskView.frame = window.frame
            window.addSubview(maskView)
            window.addSubview(collectionView)
            
            let height:CGFloat = 300
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height , width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.maskView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }) { (complete:Bool) in
                
            }
        }
        
       
    }
    
    func handleDismiss(setting:Setting){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.maskView.alpha = 0
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: self.collectionView.frame.height)
            }
        }) { (complete:Bool) in
            if setting.name != .Cancel  {
                self.homeVC?.showViewControllerForSetting(setting: setting)
            }
        }
    }
    
    //UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
       
        handleDismiss(setting:setting)
    }
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
