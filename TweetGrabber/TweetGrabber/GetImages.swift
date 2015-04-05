//
//  GetImages.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 4/3/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class GetImages {
  
  let imageQueue = NSOperationQueue()
  
  func getUserImages(url: String, completionHandler: (UIImage?) -> ()) {
    self.imageQueue.addOperationWithBlock { () -> Void in
      if let url = NSURL(string: url) {
        if let imageData = NSData(contentsOfURL: url) {
          if let image = UIImage(data: imageData) {
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
              (completionHandler(image))
            })
          }
        }
      }
    }
  }
}
