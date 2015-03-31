//
//  TweetClass.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import Foundation

class Tweet {
  
  let text:String
  let name:String
  
  init(tweetText:String, tweetName:String) {
    self.text = tweetText
    self.name = tweetName
  }
}
