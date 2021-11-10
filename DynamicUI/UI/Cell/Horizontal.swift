//
//  Horizontal.swift
//  DynamicUI
//
//  Created by Mahan Mirshafa on 11/9/21.
//

import Foundation
import UIKit

class Horizontal: CollectionViewCellBase {
    
    private lazy var cv: SubDynamicCollection = {
        let view = SubDynamicCollection()
        view.clipsToBounds = false
        view.delegate = self
        view.dataSource = self
        view.register([Banner.self, List.self, Grid.self])
        return view
    }()
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = #colorLiteral(red: 0.8504357934, green: 0.8539432883, blue: 0.8603233099, alpha: 1)
        control.currentPageIndicatorTintColor = #colorLiteral(red: 0.1819707155, green: 0.7030096054, blue: 1, alpha: 1)
        control.isUserInteractionEnabled = false
        return control
    }()
    
    override func initialize() {
        super.initialize()
        
        clipsToBounds = false
        contentView.clipsToBounds = false
        
        contentView.addSubview(cv)
        cv.constraintToSuperview([.all], margin: .init(top: 0, left: 0, bottom: -20, right: 0))

        contentView.addSubview(pageControl)
        pageControl.constraintToSuperview([.leading, .trailing, .bottom])
        pageControl.topAnchor.constraint(equalTo: cv.bottomAnchor).isActive = true
    }
    
    var model: Box? {
        didSet {
            guard let model = model else {
                return
            }
            
            switch model.cell {
            case .banner:
                pageControl.isHidden = model.items.count <= 1
                pageControl.numberOfPages = model.items.count
                pageControl.currentPage = currentPage()
            default:
                pageControl.isHidden = true
            }
            
            cv.isPagingEnabled = model.cell != .grid
            cv.contentInset = .init(top: 0, left: model.cell == .grid ? 10 : 0, bottom: 0, right: model.cell == .grid ? 10 : 0)

            cv.reloadData()
        }
    }
}

extension Horizontal {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = currentPage()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = currentPage()
    }
    
    func currentPage() -> Int {
        Int(cv.contentOffset.x / UIScreen.main.bounds.width)
    }
    
    func scroll(to page: Int) {
        UIView.animate(withDuration: 0.3) { [self] in
            cv.contentOffset = .init(x: CGFloat(CGFloat(page) * UIScreen.main.bounds.width), y: 0)
        }
    }
}

extension Horizontal: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = model else { return 0 }
        return model.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dequeue(collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard let model = model else { return 0 }
        switch model.cell {
        case .banner, .list: return 0
        case .grid: return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 0 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = model else { return .zero }
        let size = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        switch model.cell {
        case .banner: return .init(width: size.width, height: size.height)
        case .list: return .init(width: size.width, height: size.height)
        case .grid: return .init(width: (size.width - 30) / 2, height: size.height)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cv.scrollRectToVisible(.init(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
}

extension Horizontal {
    
    func dequeue(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = model else { fatalError("Horizontal Cell: Crashed")}
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
