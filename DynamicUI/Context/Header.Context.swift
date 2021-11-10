//
//  Header.Context.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

extension Header {
    
    class Context: HeaderContextObjectProtocol {
        
        func startingPosition(currentX: CGFloat, currentY: CGFloat, margin: UIEdgeInsets) -> (CGFloat, CGFloat) {
            (margin.left, currentY)
        }
        
        func configureNextObject(currentX: CGFloat, currentY: CGFloat, for indexPath: IndexPath, currentCellFrame: CGRect, margin: UIEdgeInsets) -> (CGFloat, CGFloat) {
            var x = currentX
            var y = currentY
            
            x = margin.left
            y += currentCellFrame.height + margin.bottom
            
            return (x, y)
        }
    }
}
