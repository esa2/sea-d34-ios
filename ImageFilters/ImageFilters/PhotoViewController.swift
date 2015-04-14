//
//  PhotoViewController.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
  
  @IBOutlet weak var primaryImageView: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var photoButton: UIButton!
  @IBOutlet weak var collectionViewBottomLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewTopLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewRightLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewLeftLayoutConstraint: NSLayoutConstraint!
  @IBOutlet weak var imageViewBottomLayoutConstraint: NSLayoutConstraint!
  
  var originalImageViewTopLayoutConstraint: CGFloat = 21.0
  var originalImageViewRightLayoutConstraint: CGFloat = 16.0
  var originalImageViewLeftLayoutConstraint: CGFloat = 16.0
  var originalImageViewBottomLayoutConstraint: CGFloat = 35.0
  var collectionViewFilterModeBottomLayoutConstraint: CGFloat = 8
  let animationDuration = 0.4
  let constraintBuffer: CGFloat = 60
  let alertController = UIAlertController(title: "Choose an option", message: "Select a photo, then apply a filter", preferredStyle: UIAlertControllerStyle.ActionSheet)
  var filters: [(UIImage, CIContext) -> (UIImage)]!
  var context: CIContext!
  let imageToUploadSize = CGSize(width: 400, height: 400)
  let thumbnailSize = CGSize(width: 75, height: 75)
  var originalThumbnail : UIImage!
  
  var currentImage : UIImage! {
    didSet {
      self.primaryImageView.image = self.currentImage
      self.originalThumbnail = ImageResizer.resizeImage(self.currentImage, size: self.thumbnailSize)
      self.collectionView.reloadData()
     }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let options = [kCIContextWorkingColorSpace: NSNull()]
    let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
    self.context = CIContext(EAGLContext: eaglContext, options: options)
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.collectionViewBottomLayoutConstraint.constant = -self.tabBarController!.tabBar.frame.height - self.collectionView.frame.height
    
    self.filters = [FilterService.glassDistortion,  FilterService.colorInvert, FilterService.instant, FilterService.chrome, FilterService.noir, FilterService.sepia, FilterService.lightTunnel]

    let imagePickerController = UIImagePickerController()
    imagePickerController.allowsEditing = true
    imagePickerController.delegate = self

    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
      let cameraAction = UIAlertAction(title: "Take a photo", style: UIAlertActionStyle.Default) { (action) -> Void in
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePickerController, animated: true, completion: nil)
      }
      self.alertController.addAction(cameraAction)
    }
    
    let photoLibrary = UIAlertAction(title: "Pick from Photo Library", style: UIAlertActionStyle.Default) { (action) -> Void in
      imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
      self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    self.alertController.addAction(photoLibrary)
    
    let collectionAction = UIAlertAction(title: "Photo Collection", style: UIAlertActionStyle.Default) { [weak self] (action) -> Void in
      if self != nil {
        self?.performSegueWithIdentifier("CollectionViewSegue", sender: PhotoViewController.self)
      }
    }
    self.alertController.addAction(collectionAction)
    
    let filtersAction = UIAlertAction(title: "Apply filters to selected photo", style: UIAlertActionStyle.Default) { [weak self] (action) -> Void in
      if self != nil {
      self!.enterFilterMode()
      }
    }
    self.alertController.addAction(filtersAction)
    
    let uploadAction = UIAlertAction(title: "Upload image to Parse", style: UIAlertActionStyle.Default) { (action) -> Void in
      ParseService.uploadImage(self.primaryImageView.image!, size: self.imageToUploadSize, completionHandler: { (errorDescription) -> Void in
      })
    }
    self.alertController.addAction(uploadAction)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
      }
    self.alertController.addAction(cancelAction)
    
    self.currentImage = UIImage(named: "nightview.jpg")
  }
  
  func enterFilterMode() {
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "leaveFilterMode")
    self.photoButton.enabled = false
    self.imageViewTopLayoutConstraint.constant = self.imageViewTopLayoutConstraint.constant + self.constraintBuffer
    self.imageViewRightLayoutConstraint.constant = self.imageViewRightLayoutConstraint.constant + self.constraintBuffer
    self.imageViewLeftLayoutConstraint.constant = self.imageViewLeftLayoutConstraint.constant + self.constraintBuffer
    self.imageViewBottomLayoutConstraint.constant = self.imageViewBottomLayoutConstraint.constant + self.constraintBuffer
    self.collectionViewBottomLayoutConstraint.constant = self.collectionViewFilterModeBottomLayoutConstraint
    
    UIView.animateWithDuration(self.animationDuration, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
  }
  
  func leaveFilterMode() {
    self.navigationItem.rightBarButtonItem = nil
    self.photoButton.enabled = true
    self.imageViewTopLayoutConstraint.constant = self.originalImageViewTopLayoutConstraint
    self.imageViewRightLayoutConstraint.constant = self.originalImageViewRightLayoutConstraint
    self.imageViewLeftLayoutConstraint.constant = self.originalImageViewLeftLayoutConstraint
    self.imageViewBottomLayoutConstraint.constant = self.originalImageViewBottomLayoutConstraint
    self.collectionViewBottomLayoutConstraint.constant = -self.tabBarController!.tabBar.frame.height - self.collectionView.frame.height
    
    UIView.animateWithDuration(self.animationDuration, animations: { () -> Void in
      self.view.layoutIfNeeded()
    })
  }

  @IBAction func photoButtonPressed(sender: UIButton?) {
    if let popoverController = self.alertController.popoverPresentationController {
      if let button = sender {
        popoverController.sourceView = button
        popoverController.sourceRect = button.bounds
      }
    }
    self.presentViewController(alertController, animated: true) { () -> Void in
    }
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
    if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
      self.currentImage = editedImage
    }
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   return self.filters.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FilterCell", forIndexPath: indexPath) as! FilterViewCell
    let filter = self.filters[indexPath.row]
    cell.filterImage.image = filter(self.originalThumbnail,self.context)
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let filter = self.filters[indexPath.row]
    self.currentImage = filter(self.currentImage, self.context)
  }
}