//
//  Header.SeeAll.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

extension Header {
    
    class SeeAll: UIView {
        
        lazy var label: UILabel = {
            let res = UILabel()
            res.text = "See All"
            return res
        }()
        
        lazy var margin = UIView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(label)
            label.constraintToSuperview([.all])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
