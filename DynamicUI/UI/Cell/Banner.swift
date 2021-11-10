//
//  Banner.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit
import SDWebImage

class Banner: CollectionViewCellBase {
    
    private lazy var shadow = ShadowedBlock()
    private lazy var image: UIImageView = {
        let res = UIImageView()
        res.contentMode = .scaleAspectFill
        res.layer.masksToBounds = true
        res.layer.cornerRadius = 8
        return res
    }()
    
    private lazy var label = UILabel()
    private lazy var price = UILabel()
    
    override func initialize() {
        super.initialize()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        
        shadow.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shadow)
        shadow.constraintToSuperview([.all], margin: .init(top: 4, left: 10, bottom: -4, right: -10))
        
        shadow.contentView.addSubview(image)
        image.constraintToSuperview([.top, .bottom, .leading])
        
        widthCon = image.widthAnchor.constraint(equalTo: shadow.contentView.widthAnchor, multiplier: 1)
        widthCon?.isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        price.translatesAutoresizingMaskIntoConstraints = false
        shadow.contentView.addSubview(self.price)
    }
    
    private var widthCon: NSLayoutConstraint?
    
    var model: Box.Item? {
        didSet {
            guard let model = model else { return }
            image.sd_setImage(with: URL(string: model.image.url), completed: nil)
            
            if (model.name != nil) || (model.price != nil) {
                
                if model.name != nil {
                    label.text = model.name
                    label.centerYAnchor.constraint(equalTo: shadow.contentView.centerYAnchor).isActive = true
                    label.trailingAnchor.constraint(equalTo: shadow.contentView.trailingAnchor, constant: -10).isActive = true
                    label.widthAnchor.constraint(equalTo: shadow.contentView.widthAnchor, multiplier: 0.5, constant: -20).isActive = true
                } else {
                    
                }
                
                if let price = model.price {
                    self.price.text = "\(price.price)\(price.currency)"
                    
                    self.price.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
                    self.price.trailingAnchor.constraint(equalTo: shadow.contentView.trailingAnchor, constant: -10).isActive = true
                    self.price.widthAnchor.constraint(equalTo: shadow.contentView.widthAnchor, multiplier: 0.5, constant: -20).isActive = true
                }
                
                widthCon?.isActive = false
                widthCon = image.widthAnchor.constraint(equalTo: shadow.contentView.widthAnchor, multiplier: 0.5)
                widthCon?.isActive = true
            } else {
                
                widthCon?.isActive = false
                widthCon = image.widthAnchor.constraint(equalTo: shadow.contentView.widthAnchor, multiplier: 1)
                widthCon?.isActive = true
            }
            
            superview?.layoutIfNeeded()
        }
    }
}
