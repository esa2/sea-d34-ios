//
//  CollectionViewController.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/10/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit
import Photos

protocol ImageSelectedDelegate : class  {
  func controllerDidSelectImage(image : UIImage) -> Void
}

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet weak var collectionView: UICollectionView!
 
  var results: PHFetchResult!
  var imageManager : PHCachingImageManager!
  var flowLayout: UICollectionViewFlowLayout!
  let cellSize = CGSize(width: 100, height: 100)
  let primaryImageViewSize = CGSize(width: 500, height: 500)
  let scaleFactorOne: CGFloat = 1.0
  var delegate: ImageSelectedDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.results = PHAsset.fetchAssetsWithOptions(nil)
    self.imageManager = PHCachingImageManager()
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    
    let pinch = UIPinchGestureRecognizer(target: self, action: "collectionViewPinched:")
    self.collectionView.addGestureRecognizer(pinch)
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.results.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
    let asset = self.results[indexPath.row] as! PHAsset
    self.imageManager.requestImageForAsset(asset, targetSize: cell.frame.size, contentMode: PHImageContentMode.AspectFill, options: nil) { (image, info) -> Void in
      if image != nil {
        cell.imageView.image = image
      }
    }
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let asset = self.results[indexPath.row] as! PHAsset
    self.imageManager.requestImageForAsset(asset, targetSize: self.primaryImageViewSize, contentMode: PHImageContentMode.AspectFill, options: nil) {[weak self] (image, info) -> Void in
      if self != nil {
        if image != nil {
          self!.navigationController?.popToRootViewControllerAnimated(true)
        }
      }
    }
  }

  func collectionViewPinched(pinch : UIPinchGestureRecognizer) {
    if pinch.state == UIGestureRecognizerState.Changed {
      let oldSize = self.flowLayout.itemSize
      self.collectionView.transform = CGAffineTransformScale(self.collectionView.transform, pinch.scale, pinch.scale)
      pinch.scale = scaleFactorOne
      self.collectionView.performBatchUpdates({ () -> Void in
      self.flowLayout.invalidateLayout()
      }, completion: nil)
    }
  }
}