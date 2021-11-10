//
//  Layout.Context.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

extension BaseLayout {
    
    struct context {
        
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        
        var size: CGSize = .zero
        
        mutating func restart() {
            currentX = 0
            currentY = 0
            size = .zero
        }
    }
}
