//
//  ParseService.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import Foundation

var parseImages: [UIImage]! = []

class ParseService {
  
  class func uploadImage(originalImage: UIImage, size: CGSize, completionHandler: (String?) -> Void) {
    
    let resizedImage = ImageResizer.resizeImage(originalImage, size: size)
    let imageData = UIImageJPEGRepresentation(resizedImage, 1.0)
    //let imageData = UIImagePNGRepresentation(resizedImage)
    let imageFile = PFFile(name:"image.jpg", data:imageData)
    var filteredImages = PFObject(className:"FilteredImages")
    filteredImages["imageName"] = "Stars"
    filteredImages["imageFile"] = imageFile
    filteredImages.saveInBackgroundWithBlock {(success: Bool, error) -> Void in
      if (success) {
        println("Image was saved")
      } else {
        println("Parse server error")
      }
    }
  }
  
  class func queryImageObjects(completionHandler: (data: [UIImage]?, error: String?) -> Void) {
    var query = PFQuery(className: "FilteredImages")
    query.orderByDescending("objectId")
    
    query.findObjectsInBackgroundWithBlock {(data, error) -> Void in
      if error != nil {
        println("Error in retrieving \(error)")
        return
      }
      
      if let objects = data as? [PFObject] {
        for object in objects {
          if let file = object["imageFile"] as? PFFile {
            file.getDataInBackgroundWithBlock { (data, error) -> Void in
              if (error == nil) {
                let image = UIImage(data: data!)
                println(image)
                parseImages.append(image!)
                completionHandler(data: parseImages, error: nil)
              } else {
                completionHandler(data: nil, error: "Parse server error")
              }
            }
          }
        }
      }
    }
  }
}