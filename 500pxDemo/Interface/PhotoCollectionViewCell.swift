//
//  PhotoCollectionViewCell.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-22.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import INSPhotoGallery

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    func populateWithPhoto(_ photo: INSPhotoViewable) {
        photo.loadImageWithCompletionHandler { [weak photo] (image, error) in
            if let image = image {
                if let photo = photo as? INSPhoto {
                    photo.image = image
                }
                self.photoImage.image = image
            }
        }
    }
}
