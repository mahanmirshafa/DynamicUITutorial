//
//  Grid.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class Grid: CollectionViewCellBase {
    
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
        
        contentView.addSubview(shadow)
        shadow.constraintToSuperview([.all])
        
        shadow.contentView.addSubview(image)
        image.constraintToSuperview([.top, .trailing, .leading], margin: .init(top: 8, left: 8, bottom: 0, right: -8))
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        
        shadow.contentView.addSubview(label)
        label.heightAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        label.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        label.constraintToSuperview([.leading, .trailing], margin: .init(top: 0, left: 8, bottom: 0, right: -8))
        
        shadow.contentView.addSubview(price)
        price.heightAnchor.constraint(lessThanOrEqualToConstant: 20).isActive = true
        price.constraintToSuperview([.leading, .trailing], margin: .init(top: 0, left: 8, bottom: -8, right: -8))
        price.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
    }
    
    var model: Box.Item? {
        didSet {
            guard let model = model else { return }
            image.sd_setImage(with: URL(string: model.image.url), completed: nil)
            
            if let priceModel = model.price {
                price.alpha = 1
                price.text = "\(priceModel.price)\(priceModel.currency)"
            } else {
                price.alpha = 0
            }
            
            if let name = model.name {
                label.alpha = 1
                label.text = name
            } else {
                label.alpha = 0
            }
        }
    }
}
