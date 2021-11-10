//
//  SubDynamicCollection.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class SubDynamicCollection: UICollectionView {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
