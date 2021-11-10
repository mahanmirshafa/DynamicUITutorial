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
    
    override func initialize() {
        super.initialize()
        
        contentView.addSubview(shadow)
        shadow.constraintToSuperview([.all], margin: .init(top: 4, left: 10, bottom: -4, right: -10))
        
        shadow.contentView.addSubview(image)
        image.constraintToSuperview([.all])
    }
    
    var model: Box.Item? {
        didSet {
            guard let model = model else { return }
            image.sd_setImage(with: URL(string: model.image.url), completed: nil)
            
//            if model.name
        }
    }
}
