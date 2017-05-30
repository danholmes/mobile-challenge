//
//  GreedoSizeCalculator.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-29.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import UIKit

protocol GreedoSizeCalculatorDataSource: NSObjectProtocol {
    func greedoSizeCalculator(_ calculator: GreedoSizeCalculator, originalImageSizeAt: IndexPath) -> CGSize
}

class GreedoSizeCalculator: NSObject {
    
    weak var dataSource: GreedoSizeCalculatorDataSource?
    var sizeCache: [IndexPath: NSValue] = [:]
    var leftOvers: [NSValue] = []
    var lastIndexPathAdded: IndexPath?
    var rowMaximumHeight: CGFloat
    var fixedHeight: Bool
    var contentWidth: CGFloat
    var interItemSpacing: CGFloat
    
    init (dataSource: GreedoSizeCalculatorDataSource, rowMaximumHeight: CGFloat, contentWidth: CGFloat, interItemSpacing: CGFloat, fixedHeight: Bool = false) {
        self.dataSource = dataSource
        self.rowMaximumHeight = rowMaximumHeight
        self.contentWidth = contentWidth
        self.interItemSpacing = interItemSpacing
        self.fixedHeight = fixedHeight
        super.init()
    }
    
    func sizeForPhotoAtIndexPath(_ indexPath: IndexPath) -> CGSize {
        if (self.sizeCache[indexPath] == nil) {
            self.lastIndexPathAdded = indexPath
            self.computeSizesAtIndexPath(indexPath)
        }
        var size = self.sizeCache[indexPath]!.cgSizeValue
        if (size.width < 0.0 || size.height < 0.0) {
            size = CGSize.zero
        }
        print("ip: %@ size: %f %f \n \n", indexPath, size.width, size.height)
        return size
    }
    
    func clearCache() {
        self.sizeCache.removeAll()
    }
    
    func clearCacheAfterIndexPath(_ indexPath: IndexPath) {
        // Remove the indexpath
        self.sizeCache.removeValue(forKey: indexPath)
        // Remove the indexpath for anything after
        for existingIndexPath in self.sizeCache.keys {
            if (indexPath.compare(existingIndexPath) == .orderedDescending) {
                self.sizeCache.removeValue(forKey: existingIndexPath)
            }
        }
    }
    
    func computeSizesAtIndexPath(_ indexPath: IndexPath) {
        
        guard self.dataSource != nil else { return }
        
        var photoSize = self.dataSource!.greedoSizeCalculator(self, originalImageSizeAt: indexPath)
        
        if (photoSize.width < 1 || photoSize.height < 1) {
            // Photo with no height or width
            photoSize.width = self.rowMaximumHeight
            photoSize.height = self.rowMaximumHeight
        }
        
        self.leftOvers.append(NSValue(cgSize: photoSize))
        
        var enoughContentForRow = false
        var rowHeight = self.rowMaximumHeight
        var widthMultiplier: CGFloat = 1.0
        
        // Calculations for variable height grid
        if (self.fixedHeight) {
            var totalWidth: CGFloat = 0
            var index: Int = 0
            
            for leftOver in self.leftOvers {
                let leftOverSize = leftOver.cgSizeValue
                var scaledWidth = ceil((rowHeight * leftOverSize.width) / leftOverSize.height)
                scaledWidth += self.interItemSpacing
                
                if ((totalWidth + (scaledWidth * 0.66)) > self.contentWidth) {
                    // Adding this photo would mean less than 2/3 of it would be visible
                    enoughContentForRow = true
                    self.leftOvers.remove(at: index)
                    break
                }
                
                totalWidth += scaledWidth
                enoughContentForRow = (totalWidth > self.contentWidth)
                index += 1
            }
            
            if enoughContentForRow {
                widthMultiplier = totalWidth / self.contentWidth
            }
        } else {
            var totalAspectRatio: CGFloat = 0
            
            for leftOver in self.leftOvers {
                let leftOverSize = leftOver.cgSizeValue
                totalAspectRatio += leftOverSize.width / leftOverSize.height
            }
            
            rowHeight = self.contentWidth / totalAspectRatio
            enoughContentForRow = rowHeight < self.rowMaximumHeight
        }
        
        if enoughContentForRow {
            // The line is full!
            
            var availableSpace = self.contentWidth
            var index: Int = 0
            
            for leftOver in self.leftOvers {
                
                let leftOverSize = leftOver.cgSizeValue
                
                var newWidth = floor((rowHeight * leftOverSize.width) / leftOverSize.height)
                
                if self.fixedHeight {
                    if index == (self.leftOvers.count - 1) {
                        newWidth = availableSpace
                    } else {
                        newWidth = floor(newWidth * widthMultiplier)
                    }
                } else {
                    newWidth = min(availableSpace, newWidth)
                }
                
                // Add the size in the cache
                let newValueCGSize = CGSize(width: newWidth, height: rowHeight)
                let newValue = NSValue(cgSize: newValueCGSize)
                self.sizeCache.updateValue(newValue, forKey: self.lastIndexPathAdded!)
                
                availableSpace -= newWidth
                availableSpace -= self.interItemSpacing
                
                // We need to keep track of the last index path added
                self.lastIndexPathAdded = IndexPath(item: (self.lastIndexPathAdded!.item + 1), section: self.lastIndexPathAdded!.section)
                index += 1
            }
            
            self.leftOvers.removeAll()
        } else {
            // The line is not full, let's ask the next photo and try to fill up the line
            self.computeSizesAtIndexPath(IndexPath(item: (self.lastIndexPathAdded!.item + 1), section: self.lastIndexPathAdded!.section))
        }
    }
}
