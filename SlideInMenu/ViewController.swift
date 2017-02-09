//
//  ViewController.swift
//  SlideInMenu
//
//  Created by hongbozheng on 2/8/17.
//  Copyright © 2017 fiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var settingLauncher:SlideInMenu = {
       let tmpLauncher = SlideInMenu()
        tmpLauncher.homeVC = self
        return tmpLauncher
    }()
    
    lazy var moreBtn:UIButton = {
       let btn = UIButton()
        btn.setTitle("Show More", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        let image = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handlemore))
        moreBtn.frame = CGRect(x: view.frame.width/2 - 75, y: 200, width: 150, height: 30)
        //view.addSubview(moreBtn)
        moreBtn.addTarget(self, action: #selector(handlemore), for: .touchUpInside)
       
        
    }
    
    func showViewControllerForSetting(setting:Setting)  {
        let dumpVc = UIViewController()
        dumpVc.view.backgroundColor = UIColor.white
        dumpVc.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(dumpVc, animated: true)
    }

    func handlemore(){
        settingLauncher.showSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

