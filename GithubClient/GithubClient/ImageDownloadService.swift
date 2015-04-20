
//
//  ImageDownloadService.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/16/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class ImageDownloadService {
  
  let imageQueue = NSOperationQueue()
  
  func downloadImageForURL(url: String, completionHandler: (UIImage?) -> (Void)) {
    self.imageQueue.addOperationWithBlock { () -> Void in
      if let imageData = NSData(contentsOfURL: NSURL(string: url)!) {
        let image = UIImage(data: imageData)
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          completionHandler(image)
        })
      }
    }
  }
}