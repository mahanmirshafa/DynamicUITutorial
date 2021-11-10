//
//  DynamicCollection.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class DynamicCollection: UICollectionView {
    
    init(_ delegate: BaseLayoutDelegate) {
        let layout = BaseLayout(delegate: delegate)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    
    public func register(_ cellList: [UICollectionViewCell.Type]) {
        
        for list in cellList {
            if list.isSubclass(of: UICollectionViewCell.self) {
                register(list.self, forCellWithReuseIdentifier: list.reuseId())
            }
        }
    }
}
