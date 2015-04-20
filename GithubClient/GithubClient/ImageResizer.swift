//
//  ImageResizer.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

let xLocation: CGFloat = 0.0
let yLocation: CGFloat = 0.0

class ImageResizer {
  
  class func resizeImage(originalImage: UIImage, size: CGSize) -> UIImage {
    UIGraphicsBeginImageContext(size)
    originalImage.drawInRect(CGRect(x: xLocation, y: yLocation, width: size.width, height: size.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }
}
