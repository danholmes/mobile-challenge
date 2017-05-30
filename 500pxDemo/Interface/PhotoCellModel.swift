//
//  PhotoCellModel.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-22.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import INSPhotoGallery
import Alamofire
import AlamofireImage
import AlamofireObjectMapper

class PhotoCellModel: NSObject, INSPhotoViewable {
    var image: UIImage?
    var thumbnailImage: UIImage?
    
    var attributedTitle: NSAttributedString?
    
    var photoData: PhotoInfo
    
    var photoSize: CGSize {
        get {
            if let thumb = self.thumbnailImage {
                return thumb.size
            } else if let img = self.image {
                return img.size
            } else if (photoData.width != nil && photoData.height != nil) {
                let sizeWidth = CGFloat(photoData.width!)
                let sizeHeight = CGFloat(photoData.height!)
                return CGSize(width: sizeWidth, height: sizeHeight)
            }
            print("ERROR, could not return valid photoSize in PhotoCellModel get")
            return CGSize.zero
        }
    }
    
    init(photoData: PhotoInfo) {
        self.photoData = photoData
        super.init()
    }
    
    func loadImageWithCompletionHandler(_ completion: @escaping (UIImage?, Error?) -> ()) {
        Alamofire.request(FiveHundredPxAPI.Router.PhotoDetails(photoData.id, .Full)).responseObject (keyPath:"photo") { (response: DataResponse<PhotoInfo>) in
            if let fullData = response.value {
                self.photoData = fullData
                if let imageURL = self.photoData.imageUrl {
                    Alamofire.request(imageURL).responseImage(completionHandler: { (response: DataResponse<Image>) in
                        if let image = response.value {
                            completion(image, nil)
                        }
                    })
                }
            } else if let error = response.error {
                print("%@", error)
            }
        }
    }
    
    func loadThumbnailImageWithCompletionHandler(_ completion: @escaping (UIImage?, Error?) -> ()) {
        if let imageURL = self.photoData.imageUrl {
            Alamofire.request(imageURL).responseImage(completionHandler: { (response: DataResponse<Image>) in
                if let image = response.value {
                    completion(image, nil)
                }
            })
        }
    }
}
