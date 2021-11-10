//
//  UIView+Constraint.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/7/21.
//

import Foundation
import UIKit

extension UIView {
    
    public enum Anchor {
        case all, top, bottom, leading, trailing
    }
    
    public func constraintToSuperview(_ anchors: [Anchor], margin: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        for anchor in anchors {
            switch anchor {
            case .all:
                NSLayoutConstraint.activate([
                    topAnchor.constraint(equalTo: superview.topAnchor, constant: margin.top),
                    bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: margin.bottom),
                    leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margin.left),
                    trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: margin.right)
                ])
                break;
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: margin.top).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: margin.bottom).isActive = true
            case .leading:
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margin.left).isActive = true
            case .trailing:
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: margin.right).isActive = true
            }
        }
    }
    
    public func constraintToSize(_ size: CGSize) {
        constraintToWidth(size.width)
        constraintToHeight(size.height)
    }
    
    public func constraintToHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func constraintToWidth(_ width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}
