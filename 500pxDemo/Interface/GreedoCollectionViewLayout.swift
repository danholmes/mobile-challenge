//
//  GreedoCollectionViewLayout.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-30.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import UIKit

protocol GreedoCollectionViewLayoutDataSource: NSObjectProtocol {
    func greedoCollectionViewLayout(_ layout: GreedoCollectionViewLayout, originalImageSizeAtIndexPath indexPath: IndexPath) -> CGSize
}

class GreedoCollectionViewLayout: NSObject, GreedoSizeCalculatorDataSource {
    
    weak var dataSource: GreedoCollectionViewLayoutDataSource?
    var rowMaximumHeight: CGFloat! {
        get {
            return self.greedo.rowMaximumHeight
        }
        set {
            self.greedo.rowMaximumHeight = newValue
        }
    }
    var fixedHeight: Bool! {
        get {
            return self.greedo.fixedHeight
        }
        set {
            self.greedo.fixedHeight = newValue
        }
    }
    var collectionView: UICollectionView
    lazy var greedo: GreedoSizeCalculator = {
        [unowned self] in
        return GreedoSizeCalculator(dataSource: self, rowMaximumHeight: 100, contentWidth: 100, interItemSpacing: 0)
    }()
    
    init(dataSource: GreedoCollectionViewLayoutDataSource, collectionView: UICollectionView) {
        self.dataSource = dataSource
        self.collectionView = collectionView
    }
    
    func sizeForPhotoAtIndexPath(_ indexPath: IndexPath) -> CGSize {
        
        var contentWidth = self.collectionView.bounds.size.width
        var interitemSpacing: CGFloat = 0.0
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            contentWidth -= (layout.sectionInset.left + layout.sectionInset.right)
            interitemSpacing = layout.minimumInteritemSpacing
        }
        
        self.greedo.contentWidth = contentWidth
        self.greedo.interItemSpacing = interitemSpacing
        
        return self.greedo.sizeForPhotoAtIndexPath(indexPath)
    }
    
    func clearCache() {
        self.greedo.clearCache()
    }
    
    func clearCacheAfterIndexPath(_ indexPath: IndexPath) {
        self.greedo.clearCacheAfterIndexPath(indexPath)
    }
    
    func greedoSizeCalculator(_ calculator: GreedoSizeCalculator, originalImageSizeAt indexPath: IndexPath) -> CGSize {
        return self.dataSource!.greedoCollectionViewLayout(self, originalImageSizeAtIndexPath: indexPath)
    }
    
    
}
