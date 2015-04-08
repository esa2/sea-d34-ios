//
//  FilterService.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit
import CoreImage

class FilterService {
  
  class func lightTunnel(originalImage: UIImage) -> UIImage {
    
    let image = CIImage(image: originalImage)
    let lightTunnel = CIFilter(name: "CILightTunnel")
    
    lightTunnel.setDefaults()
    lightTunnel.setValue(image, forKey: kCIInputImageKey)
    let vector = CIVector(x: 150, y: 150)
    lightTunnel.setValue(vector, forKey: kCIInputCenterKey)
    lightTunnel.setValue(100.00, forKey: kCIInputRadiusKey)
    let result = lightTunnel.valueForKey(kCIOutputImageKey) as CIImage
    
    for input in lightTunnel.inputKeys() {
      println(input)
    }
    
    let options = [kCIContextWorkingColorSpace: NSNull()]
    let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
    let context = CIContext(EAGLContext: eaglContext, options: options)
    let rect = CGRect(origin: CGPointZero, size: originalImage.size)
    let resultRef = context.createCGImage(result, fromRect: rect)
    return UIImage(CGImage: resultRef)!
  }

  class func glassDistortion(originalImage: UIImage) -> UIImage {
    
    let image = CIImage(image: originalImage)
    let glassDistortion = CIFilter(name: "CIGlassDistortion")
    glassDistortion.setDefaults()
    glassDistortion.setValue(image, forKey: kCIInputImageKey)
    let textureImage = CIImage(image: originalImage)
    glassDistortion.setValue(textureImage, forKey: "inputTexture")
    let vector = CIVector(x: 150, y: 150)
    glassDistortion.setValue(vector, forKey: kCIInputCenterKey)
    glassDistortion.setValue(200.00, forKey: kCIInputScaleKey)
    let result = glassDistortion.valueForKey(kCIOutputImageKey) as CIImage
      
    for input in glassDistortion.inputKeys() {
      println(input)
    }

    let options = [kCIContextWorkingColorSpace: NSNull()]
    let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
    let context = CIContext(EAGLContext: eaglContext, options: options)
    let resultRef = context.createCGImage(result, fromRect: result.extent())
    return UIImage(CGImage: resultRef)!
  }
  
  class func colorInvert(originalImage: UIImage) -> UIImage {
    
    let image = CIImage(image: originalImage)
    let colorInvert = CIFilter(name: "CIColorInvert")
    colorInvert.setDefaults()
    colorInvert.setValue(image, forKey: kCIInputImageKey)
    let result = colorInvert.valueForKey(kCIOutputImageKey) as CIImage
    
    for input in colorInvert.inputKeys() {
      println(input)
    }
    
    let options = [kCIContextWorkingColorSpace: NSNull()]
    let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
    let context = CIContext(EAGLContext: eaglContext, options: options)
    
    let resultRef = context.createCGImage(result, fromRect: result.extent())
    return UIImage(CGImage: resultRef)!
  }
}
