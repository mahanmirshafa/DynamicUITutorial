//
//  BaseLayout.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/8/21.
//

import Foundation
import UIKit

protocol BaseLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, hasHeaderInSection section: Int) -> Bool
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, contextObjectForHeaderAt indexPath: IndexPath) -> HeaderContextObjectProtocol
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, sizeForHeaderAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, marginForHeaderAt indexPath: IndexPath) -> UIEdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, contextObjectForCellIn section: Int) -> CellContextObjectProtocol
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, marginForCellIn section: Int) -> UIOffset // Top, Left
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, interItemSpacingForSection section: Int) -> UIOffset // x: horizontal, y: vertical
}

protocol HeaderContextObjectProtocol {
    
    func startingPosition(currentX: CGFloat, currentY: CGFloat, margin: UIEdgeInsets) -> (CGFloat, CGFloat)
    func configureNextObject(currentX: CGFloat, currentY: CGFloat, for indexPath: IndexPath, currentCellFrame: CGRect, margin: UIEdgeInsets) -> (CGFloat, CGFloat)
}

protocol CellContextObjectProtocol {
    
    func startingPosition(currentX: CGFloat, currentY: CGFloat, margin: UIOffset) -> (CGFloat, CGFloat) // x, y
    func configureNextObject(currentX: CGFloat, currentY: CGFloat, for indexPath: IndexPath, collectionView: UICollectionView, cellFrame: CGRect, margin: UIOffset, interItemSpacing: UIOffset) -> (CGFloat, CGFloat)
}

class BaseLayout: UICollectionViewLayout {
    
    open var layoutAttributes: Dictionary<String, UICollectionViewLayoutAttributes> = [:]
    open var contentSize: CGSize = .zero
    
    var _context: context
    
    let delegate: BaseLayoutDelegate
    init(delegate: BaseLayoutDelegate) {
        self.delegate = delegate
        _context = context()
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var collectionViewContentSize: CGSize {
        contentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        Array(layoutAttributes.filter{ $0.value.frame.intersects(rect) }.values)
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        layoutAttributes.removeAll()
        
        _context.restart()
        
        _context.size = collectionView.frame.size
        
        for section in 0..<collectionView.numberOfSections {
            
            // Headers
            if delegate.collectionView(collectionView, layout: self, hasHeaderInSection: section) {
                
                let headerIndexPath = IndexPath(item: 0, section: section)
                let headerLayoutAttribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: headerIndexPath)
                
                let margin = delegate.collectionView(collectionView, layout: self, marginForHeaderAt: headerIndexPath)
                
                let contextObject = delegate.collectionView(collectionView, layout: self, contextObjectForHeaderAt: headerIndexPath)
                
                let headerStartTuple = contextObject.startingPosition(currentX: _context.currentX, currentY: _context.currentY, margin: margin)
                _context.currentX = headerStartTuple.0
                _context.currentY = headerStartTuple.1
                
                let sizeForHeader = delegate.collectionView(collectionView, layout: self, sizeForHeaderAt: headerIndexPath)
                
                headerLayoutAttribute.frame = .init(x: _context.currentX, y: _context.currentY, width: sizeForHeader.width, height: sizeForHeader.height)
                headerLayoutAttribute.zIndex = 10
                
                let headerKey = layoutKey(forItemKind: .supplementary(kind: UICollectionView.elementKindSectionHeader), indexPath: headerIndexPath)
                layoutAttributes[headerKey] = headerLayoutAttribute
                
                let headerConfigureTuple = contextObject.configureNextObject(currentX: _context.currentX, currentY: _context.currentY, for: headerIndexPath, currentCellFrame: headerLayoutAttribute.frame, margin: margin)
                _context.currentX = headerConfigureTuple.0
                _context.currentY = headerConfigureTuple.1
            }
            
            let cellContext = delegate.collectionView(collectionView, layout: self, contextObjectForCellIn: section)
            let margin = delegate.collectionView(collectionView, layout: self, marginForCellIn: section)
            let interItem = delegate.collectionView(collectionView, layout: self, interItemSpacingForSection: section)
            
            let cellStartTuple = cellContext.startingPosition(currentX: _context.currentX, currentY: _context.currentY, margin: margin)
            _context.currentX = cellStartTuple.0
            _context.currentY += cellStartTuple.1
            
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                
                let indexPath = IndexPath(item: item, section: section)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                let size = delegate.collectionView(collectionView, layout: self, sizeForItemAt: indexPath)
                
                attribute.frame = .init(x: _context.currentX, y: _context.currentY, width: size.width, height: size.height)
                
                let key = layoutKey(forItemKind: .cell, indexPath: indexPath)
                layoutAttributes[key] = attribute
                
                let cellConfigureTuple = cellContext.configureNextObject(currentX: _context.currentX, currentY: _context.currentY, for: indexPath, collectionView: collectionView, cellFrame: attribute.frame, margin: margin, interItemSpacing: interItem)
                _context.currentX = cellConfigureTuple.0
                _context.currentY = cellConfigureTuple.1
            }
        }
        
        self.contentSize = .init(width: _context.size.width, height: _context.currentY)
    }
}
