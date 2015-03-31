//
//  TweetJSONParserClass.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import Foundation

class TweetJSONParser {
  
  class func JSONTweetsFromTwitter(data:NSData) -> [Tweet] {
    
    var tweets = [Tweet]()
    var error : NSError?
    
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [[String:AnyObject]] {
      
      for object in jsonObject {
        if let text = object["text"] as? String {
          if let user = object["user"] as? [String: AnyObject] {
            if let name = user["name"] as? String {
              let tweet = Tweet(tweetText: text, tweetName: name)
              tweets.append(tweet)
              }
            }
          }
        }
      }
    return tweets
  }
}
