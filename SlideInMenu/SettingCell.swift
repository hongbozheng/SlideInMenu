//
//  SettingCell.swift
//  SlideInMenu
//
//  Created by hongbozheng on 2/8/17.
//  Copyright © 2017 fiu. All rights reserved.
//

import UIKit

class SettingCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool{
        didSet{
//            print(isHighlighted)
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
//    override var isSelected: Bool{
//        didSet{
//            backgroundColor = isSelected ? UIColor.darkGray : UIColor.white
//            nameLabel.textColor = isSelected ? UIColor.white : UIColor.black
//            iconImageView.tintColor = isSelected ? UIColor.white : UIColor.darkGray
//
//        }
//    }
    
   private let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   private let iconImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var setting:Setting?{
        didSet{
            if let name = setting?.name.rawValue, let imageName = setting?.imageName {
            nameLabel.text = name
                iconImageView.image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    func setupSubviews()  {
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0(30)]-16-[v1]-16-|", options:NSLayoutFormatOptions(), metrics: nil, views: ["v0":iconImageView,"v1":nameLabel]))
      
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: iconImageView, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

        addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height    , relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
    }
}
