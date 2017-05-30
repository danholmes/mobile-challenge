//
//  MainViewController.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-22.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import Alamofire
import INSPhotoGallery
import AlamofireObjectMapper

class MainViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = NSMutableOrderedSet()
    var fetchingPhotos: Bool = false
    var currentPage: Int = 1
    lazy var collectionViewSizeCalculator: GreedoCollectionViewLayout = {
        [unowned self] in
        return GreedoCollectionViewLayout(dataSource: self, collectionView: self.collectionView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.collectionViewSizeCalculator.rowMaximumHeight = self.collectionView.bounds.height / 3
        self.collectionViewSizeCalculator.fixedHeight = false
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
        
        self.collectionView.collectionViewLayout = layout
        
        fetchPhotos()
    }
    
    func fetchPhotos() {
        
        guard fetchingPhotos == false else { return }
        
        fetchingPhotos = true
        
        Alamofire.request(FiveHundredPxAPI.Router.Photos(.Popular, self.currentPage)).responseArray(keyPath:"photos") { (response: DataResponse<[PhotoInfo]>) in
            if let newPhotos = response.value {
                let newPhotoModels = newPhotos.map {
                    return PhotoCellModel(photoData: $0)
                }
                let lastCount = self.photos.count
                self.photos.addObjects(from: newPhotoModels)
                self.currentPage += 1
                let newCount  = self.photos.count
                let newIndexPaths = (lastCount..<newCount).map {
                    return IndexPath(item: $0, section: 0)
                }
                
                self.collectionView.insertItems(at: newIndexPaths)
            } else if let error = response.error{
                print("%@", error)
            }
            self.fetchingPhotos = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.8 {
            fetchPhotos()
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        cell.populateWithPhoto(photos[indexPath.row] as! PhotoCellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        let currentPhoto = photos[(indexPath as NSIndexPath).row]
        let galleryPreview = INSPhotosViewController(photos: (photos.array as! [PhotoCellModel]), initialPhoto: (currentPhoto as! PhotoCellModel), referenceView: cell)
        
        galleryPreview.referenceViewForPhotoWhenDismissingHandler = { [weak self] photo in
            if let index = self?.photos.array.index(where: {($0 as! PhotoCellModel).photoData.id == (photo as! PhotoCellModel).photoData.id}) {
                let indexPath = IndexPath(item: index, section: 0)
                return collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell
            }
            return nil
        }
        present(galleryPreview, animated: true, completion: nil)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionViewSizeCalculator.sizeForPhotoAtIndexPath(indexPath)
    }
}

extension MainViewController: GreedoCollectionViewLayoutDataSource {
    
    func greedoCollectionViewLayout(_ layout: GreedoCollectionViewLayout, originalImageSizeAtIndexPath indexPath: IndexPath) -> CGSize {
        // Return the image size to GreedoCollectionViewLayout
        if (indexPath.item < self.photos.count) {
            let photo = self.photos[indexPath.row] as! PhotoCellModel
            return photo.photoSize
        }
        print("FAILURE to get image size at path: %@", indexPath)
        return CGSize.zero
    }
    
}
