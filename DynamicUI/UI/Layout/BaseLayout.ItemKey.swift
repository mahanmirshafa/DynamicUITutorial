//
//  BaseLayout.ItemKey.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

extension BaseLayout {
    
    enum itemKind {
        case cell, supplementary(kind: String), decoration(kind: String)
        
        public func layoutKey(at indexPath: IndexPath) -> String {
            
            func _format(prefix: String, indexPath: IndexPath) -> String {
                "\(prefix)_\(indexPath.section)_\(indexPath.item)"
            }
            
            switch self {
            case .cell:
                return _format(prefix: "i", indexPath: indexPath)
            case .supplementary(let kind):
                if (kind == UICollectionView.elementKindSectionHeader) {
                    return _format(prefix: "h", indexPath: indexPath)
                } else if (kind == UICollectionView.elementKindSectionFooter) {
                    return _format(prefix: "f", indexPath: indexPath)
                } else {
                    return _format(prefix: "s_\(kind)", indexPath: indexPath)
                }
            case .decoration(let kind):
                return _format(prefix: "d_\(kind)", indexPath: indexPath)
            }
        }
    }
    
    public func layoutKey(forItemKind kind: itemKind, indexPath: IndexPath) -> String {
        kind.layoutKey(at: indexPath)
    }
}
