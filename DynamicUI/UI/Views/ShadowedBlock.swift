//
//  ShadowedBlock.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class ShadowedBlock: UIView {
    
    public lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3.0
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    
    private lazy var shadowPath: CGPath = {
        let bezier = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0)
        return bezier.cgPath
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.constraintToSuperview([.all], margin: .init(top: 4, left: 4, bottom: -4, right: -4))
        
        insertSubview(shadowView, belowSubview: contentView)
        shadowView.constraintToSuperview([.all], margin: .init(top: 6, left: 6, bottom: -6, right: -6))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.layer.shadowPath = shadowPath
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
