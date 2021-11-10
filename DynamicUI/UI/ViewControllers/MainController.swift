//
//  MainController.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/7/21.
//

import Foundation
import UIKit
import Preview
import SwiftUI

class MainController: UIViewController {
    
    let headerKind = UICollectionView.elementKindSectionHeader
    
    open var dataset: MainModel {
        fatalError("Must override", file: "MainController", line: 18)
    }
    
    private lazy var collectionView: DynamicCollection = {
        let view = DynamicCollection(self)
        view.contentInsetAdjustmentBehavior = .always
        view.delegate = self
        view.dataSource = self
        view.register([Horizontal.self, List.self, Grid.self, Banner.self])
        view.register(Header.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: Header.reuseIdentifier())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.constraintToSuperview([.all])
        
        collectionView.reloadData()
    }
}

extension MainController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataset.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model = dataset.items[section]
        switch model.layout {
        case .horizontal: return 1
        case .vertical: return model.items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataset.items[indexPath.section]
        switch model.layout {
        case .horizontal:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Horizontal.reuseId(), for: indexPath) as! Horizontal
            cell.model = model
            return cell
        case .vertical:
            return dequeue(collectionView, indexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let model = dataset.items[indexPath.section]
        if model.header != nil {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: headerKind, withReuseIdentifier: Header.reuseIdentifier(), for: indexPath) as! Header
            header.model = model.header
            return header
        } else {
            fatalError("Dynamic Header: Model header is null")
        }
    }
    
    func dequeue(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let model = dataset.items[indexPath.section]
        switch model.cell {
        case .banner:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Banner.reuseId(), for: indexPath) as! Banner
            cell.model = model.items[indexPath.item]
            return cell
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: List.reuseId(), for: indexPath) as! List
            cell.model = model.items[indexPath.item]
            return cell
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Grid.reuseId(), for: indexPath) as! Grid
            cell.model = model.items[indexPath.item]
            return cell
        }
    }
}

extension MainController: BaseLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, hasHeaderInSection section: Int) -> Bool {
        dataset.items[section].header != nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, contextObjectForHeaderAt indexPath: IndexPath) -> HeaderContextObjectProtocol {
        Header.Context()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, sizeForHeaderAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, marginForHeaderAt indexPath: IndexPath) -> UIEdgeInsets {
        .init(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, contextObjectForCellIn section: Int) -> CellContextObjectProtocol {
        CollectionViewCellBase.Context(dataset.items[section])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, marginForCellIn section: Int) -> UIOffset {
        let model = dataset.items[section]
        switch model.layout {
        case .horizontal:
            switch model.cell {
            case .banner, .list: return .zero
            case .grid: return .zero
            }
        case .vertical:
            switch dataset.items[section].cell {
            case .banner, .list: return .zero
            case .grid: return .init(horizontal: 10, vertical: 10)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let model = dataset.items[indexPath.section]
        switch model.cell {
        case .banner:
            switch model.layout {
            case .horizontal:
                let hasControl = model.items.count > 1
                let controlHeight = hasControl ? 20.0 : 0.0
                return .init(width: width, height: (width / 2) + controlHeight)
            case .vertical: return .init(width: width, height: (width / 2))
            }
        case .list: return .init(width: width, height: width / 4)
        case .grid:
            let hasName = model.items[indexPath.item].name != nil
            let hasPrice = model.items[indexPath.item].price != nil
            let nameAddition: CGFloat = hasName ? 30 : 0
            let priceAddition: CGFloat = hasPrice ? 30 : 0
            let image: CGFloat = (width - 30) / 2
            switch model.layout {
            case .horizontal:
                return .init(width: width, height: image + 18 + nameAddition + priceAddition)
            case .vertical:
                return .init(width: image, height: image + 18 + nameAddition + priceAddition)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: BaseLayout, interItemSpacingForSection section: Int) -> UIOffset {
        switch dataset.items[section].cell {
        case .banner, .list: return .zero
        case .grid: return .init(horizontal: 10, vertical: 10)
        }
    }
}
