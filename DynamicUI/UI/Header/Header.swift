//
//  Header.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class Header: UICollectionReusableView {
    
    public var model: Box.Header? {
        didSet {
            guard let model = model else {
                return
            }
            
            label.text = model.name
            see.isHidden = model.seeAll == nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var label = UILabel()
    private lazy var see = Header.SeeAll()
    
    private func setupViews() {
        
        label.font = .boldSystemFont(ofSize: 16)
        addSubview(label)
        label.constraintToSuperview([.leading, .top, .bottom], margin: .init(top: 0, left: 10, bottom: 0, right: 0))
        
        addSubview(see)
        see.constraintToSuperview([.top, .bottom, .trailing], margin: .init(top: 0, left: 0, bottom: 0, right: -10))
    }
}
