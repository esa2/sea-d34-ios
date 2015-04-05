//
//  TweetJSONParserClass.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class TweetJSONParser {
  
  class func JSONTweetsFromTwitter(data:NSData) -> [Tweet] {
    
    var tweets = [Tweet]()
    var error : NSError?
    
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [[String:AnyObject]] {
      for object in jsonObject {
        if let text = object["text"] as? String {
          if let user = object["user"] as? [String: AnyObject] {
            if let name = user["name"] as? String {
              if let selectedTweetID = object["id_str"] as? String {
                if let imageURL = user["profile_image_url"] as? String {
                  if let screenName = user["screen_name"] as? String {
                    if let backgroundImageURL = user["profile_background_image_url"] as? String {
                      if let location = user["location"] as? String {
                        if let description = user["description"] as? String {
                          if let extendedEntities = object["extended_entities"] as? [String: AnyObject] {
                           // println(extendedEntities)
                           // if let sourceID = extendedEntities["source_status_id"] as? String {
                              let tweet = Tweet(userImage: imageURL, tweetText: text, tweetName: name, tweetID: selectedTweetID, tweetScreenName: screenName, tweetBackgroundImageURL: backgroundImageURL, tweetLocation: location, tweetDescription: description)
                                  tweets.append(tweet)
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    return tweets
  }
  class func selectedTweetFromJSON(data :NSData) -> String? {
    var error : NSError?
    if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &error) as? [String : AnyObject] {
      if let selectedTweet = jsonObject["text"] as? String {
        return selectedTweet
      }
    }
    return nil
  }
}