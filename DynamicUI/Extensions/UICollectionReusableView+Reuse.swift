//
//  UICollectionReusableView+Reuse.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

extension UICollectionReusableView {
    
    public static func reuseIdentifier() -> String {
        String(describing: self.self)
    }
}
