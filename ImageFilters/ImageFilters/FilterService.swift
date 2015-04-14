//
//  FilterService.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit
import CoreImage

var inLightTunnel = false
let xCoordinate: CGFloat = 150.0
let yCoordinate: CGFloat = 150.0
let scalarValue: CGFloat = 150.0

class FilterService {
  
  class func glassDistortion(originalImage: UIImage, context: CIContext) -> UIImage {
    let glassDistortion = CIFilter(name: "CIGlassDistortion")
    let textureImage = CIImage(image: originalImage)
    glassDistortion.setValue(textureImage, forKey: "inputTexture")
    let vector = CIVector(x: xCoordinate, y: yCoordinate)
    glassDistortion.setValue(vector, forKey: kCIInputCenterKey)
    glassDistortion.setValue(scalarValue, forKey: kCIInputScaleKey)
    return self.filterImage(originalImage, filter: glassDistortion, context: context)
    }

  class func colorInvert(originalImage: UIImage, context: CIContext) -> UIImage {
    let colorInvert = CIFilter(name: "CIColorInvert")
    return self.filterImage(originalImage, filter: colorInvert, context: context)
  }
  
  class func sepia(originalImage: UIImage, context: CIContext) -> UIImage {
    let sepia = CIFilter(name: "CISepiaTone")
    return self.filterImage(originalImage, filter: sepia, context: context)
  }
  
  class func instant(originalImage: UIImage, context: CIContext) -> UIImage {
    let instant = CIFilter(name: "CIPhotoEffectInstant")
    instant.setDefaults()
    return self.filterImage(originalImage, filter: instant, context: context)
    }
  
  class func chrome(originalImage: UIImage, context: CIContext) -> UIImage {
    let chrome = CIFilter(name: "CIPhotoEffectChrome")
    chrome.setDefaults()
    return self.filterImage(originalImage, filter: chrome, context: context)
    }
  
  class func noir(originalImage: UIImage, context: CIContext) -> UIImage {
    let noir = CIFilter(name: "CIPhotoEffectNoir")
    noir.setDefaults()
    return self.filterImage(originalImage, filter: noir, context: context)
  }
  
  class func lightTunnel(originalImage: UIImage, context: CIContext) -> UIImage {
    inLightTunnel = true
    let lightTunnel = CIFilter(name: "CILightTunnel")
    let vector = CIVector(x: xCoordinate, y: yCoordinate)
    lightTunnel.setValue(vector, forKey: kCIInputCenterKey)
    lightTunnel.setValue(scalarValue, forKey: kCIInputRadiusKey)
    for input in lightTunnel.inputKeys() {
      println(input)
    }
    return self.filterImage(originalImage, filter: lightTunnel, context: context)
  }
  
  private class func filterImage(originalImage: UIImage, filter: CIFilter, context: CIContext) -> UIImage {
    let image = CIImage(image: originalImage)
    filter.setValue(image, forKey: kCIInputImageKey)
    let result = filter.valueForKey(kCIOutputImageKey) as! CIImage
    if inLightTunnel == false {
      let resultRef = context.createCGImage(result, fromRect: result.extent())
      return UIImage(CGImage: resultRef)!
    } else {
      let rect = CGRect(origin: CGPointZero, size: originalImage.size)
      let resultRef = context.createCGImage(result, fromRect: rect)
      return UIImage(CGImage: resultRef)!            
    }
  }
}