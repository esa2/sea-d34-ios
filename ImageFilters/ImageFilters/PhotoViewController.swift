//
//  PhotoViewController.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class PhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  let alertController = UIAlertController(title: "Choose an option", message: "Select a photo, then apply a filter", preferredStyle: UIAlertControllerStyle.ActionSheet)
  
  @IBOutlet weak var primaryImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    
    let cameraAction = UIAlertAction(title: "Pick from Photo Library", style: UIAlertActionStyle.Default) { (action) -> Void in
      imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
      self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    self.alertController.addAction(cameraAction)
    
        let lightTunnelAction = UIAlertAction(title: "Light tunnel", style: UIAlertActionStyle.Destructive) { (action) -> Void in
          let lightTunnelActionImage = FilterService.lightTunnel(self.primaryImageView.image!)
          self.primaryImageView.image = lightTunnelActionImage
        }
        self.alertController.addAction(lightTunnelAction)
    
    let glassDistortionAction = UIAlertAction(title: "Glass distortion", style: UIAlertActionStyle.Destructive) { (action) -> Void in
      let glassDistortionImage = FilterService.glassDistortion(self.primaryImageView.image!)
      self.primaryImageView.image = glassDistortionImage
    }
    self.alertController.addAction(glassDistortionAction)
    
    let colorInvertAction = UIAlertAction(title: "Color invert", style: UIAlertActionStyle.Destructive) { (action) -> Void in
      let colorInvertImage = FilterService.colorInvert(self.primaryImageView.image!)
      self.primaryImageView.image = colorInvertImage
    }
    self.alertController.addAction(colorInvertAction)
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
      self.primaryImageView.image = editedImage
    }
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    
  }
}
