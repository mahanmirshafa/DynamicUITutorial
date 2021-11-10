//
//  List.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class List: CollectionViewCellBase {
    
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
    
    private var topCons: NSLayoutConstraint?
    private var verticalCon: NSLayoutConstraint?
    
    override func initialize() {
        super.initialize()
        
        contentView.addSubview(shadow)
        shadow.constraintToSuperview([.all], margin: .init(top: 4, left: 10, bottom: -4, right: -10))
        
        shadow.contentView.addSubview(image)
        image.constraintToSuperview([.leading, .top, .bottom], margin: .init(top: 8, left: 8, bottom: -8, right: 0))
        image.heightAnchor.constraint(equalTo: image.widthAnchor).isActive = true
        
        shadow.contentView.addSubview(label)
        label.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        label.constraintToSuperview([.trailing], margin: .init(top: 0, left: 0, bottom: 0, right: -10))
        
        shadow.contentView.addSubview(price)
        price.constraintToSuperview([.bottom, .trailing], margin: .init(top: 0, left: 0, bottom: -8, right: -10))
        price.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
    }
    
    var model: Box.Item? {
        didSet {
            guard let model = model else {
                return
            }

            image.sd_setImage(with: URL(string: model.image.url), completed: nil)

            if let priceModel = model.price {
                price.alpha = 1
                price.text = "Price: \(priceModel.price)\(priceModel.currency)"

                topCons?.isActive = false
                verticalCon?.isActive = false
                topCons = label.topAnchor.constraint(equalTo: shadow.contentView.topAnchor, constant: 8)
                topCons?.isActive = true
            } else {
                
                price.alpha = 0

                topCons?.isActive = false
                verticalCon?.isActive = false
                verticalCon = label.centerYAnchor.constraint(equalTo: shadow.contentView.centerYAnchor)
                verticalCon?.isActive = true
            }

            label.text = model.name

            superview?.layoutIfNeeded()
        }
    }
}
