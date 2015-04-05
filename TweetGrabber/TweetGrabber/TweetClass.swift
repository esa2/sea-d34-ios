//
//  TweetClass.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class Tweet {
  
  var image: UIImage?
  var imageURL: String
  var text: String
  var name: String
  var ID: String
  var screenName: String
  var backgroundImageURL: String
  var location: String
  var description: String
  //var sourceID: String
  
  init(userImage: String, tweetText: String, tweetName: String, tweetID: String, tweetScreenName: String, tweetBackgroundImageURL: String, tweetLocation: String, tweetDescription: String) {
    self.imageURL = userImage
    self.text = tweetText
    self.name = tweetName
    self.ID = tweetID
    self.screenName = tweetScreenName
    self.backgroundImageURL = tweetBackgroundImageURL
    self.location = tweetLocation
    self.description = tweetDescription
    //self.sourceID = tweetSourceID
  }
}
