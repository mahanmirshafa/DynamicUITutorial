//
//  Cell.Context.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

extension CollectionViewCellBase {
    
    class Context: CellContextObjectProtocol {
        
        var model: Box
        init(_ model: Box) {
            self.model = model
        }
        
        func configureNextObject(currentX: CGFloat, currentY: CGFloat, for indexPath: IndexPath, collectionView: UICollectionView, cellFrame: CGRect, margin: UIOffset, interItemSpacing: UIOffset) -> (CGFloat, CGFloat) {
            
            var x = currentX
            var y = currentY
            
            switch model.layout {
            case .horizontal:
                y += cellFrame.size.height + interItemSpacing.horizontal
            case .vertical:
                switch model.cell {
                case .grid:
                    if (indexPath.item + 1) % 2 == 0 {
                        x = margin.horizontal
                        y += cellFrame.size.height + interItemSpacing.vertical
                    } else if (indexPath.item + 1) % 2 == 1 {
                        x += cellFrame.size.width + interItemSpacing.horizontal
                    }
                    
                    if (indexPath.item + 1) % 2 != 0 && (indexPath.item + 1) == collectionView.numberOfItems(inSection: indexPath.section) {
                        x = margin.horizontal
                        y += cellFrame.size.height + interItemSpacing.vertical
                    }
                case .list, .banner:
                    y += cellFrame.size.height + interItemSpacing.horizontal
                }
            }
            
            return (x, y)

        }
        
        func startingPosition(currentX: CGFloat, currentY: CGFloat, margin: UIOffset) -> (CGFloat, CGFloat) {
            var x = currentX
            var y = currentY
            
            x = margin.horizontal
            y = margin.vertical
            
            return (x, y)
        }
    }
}
