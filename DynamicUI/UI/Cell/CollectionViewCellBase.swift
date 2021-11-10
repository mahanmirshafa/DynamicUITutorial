//
//  CollectionViewCellBase.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class CollectionViewCellBase: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initialize() {
        
    }
}


