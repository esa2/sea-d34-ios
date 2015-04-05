//
//  GetMyTweets.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 4/1/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import Foundation
import Social
import Accounts

class GetMyTweets {
  init() {}
  
  class var sharedGetTweets: GetMyTweets {
    struct Static {
      static let instance: GetMyTweets = GetMyTweets()
    }
    return Static.instance
  }
  
  var twitterAccount: ACAccount?
  let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
  let selectedTweetURL = "https://api.twitter.com/1.1/statuses/show.json?id="
  let allTweetsURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
  
  func fetchHomeTimelineUser(requestURL: NSURL, completionHandler: ([Tweet]?, String?) -> Void){
    
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    
    twitterRequest.account = twitterAccount
    twitterRequest.performRequestWithHandler { (data, response, error: NSError?) -> Void in
      if error != nil {
        println(error?.localizedDescription)
        return
      }
      
      let status = (response as NSHTTPURLResponse).statusCode
      if status != 200 {
        println("Response status \(status). Please try again")
        return
      }
      
      var myTweets = [Tweet]()
      let errors: String? = nil
      myTweets = TweetJSONParser.JSONTweetsFromTwitter(data)
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(myTweets, errors)
      })
    }
  }

//  func fetchHomeTimeline(completionHandler: ([Tweet]?, String?) -> Void){
//    let requestURL  = NSURL(string: homeTimelineURL)
//    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
//    
//    twitterRequest.account = twitterAccount
//    twitterRequest.performRequestWithHandler { (data, response, error: NSError?) -> Void in
//      if error != nil {
//        println(error?.localizedDescription)
//        return
//      }
//      
//      let status = (response as NSHTTPURLResponse).statusCode
//      if status != 200 {
//        println("Response status \(status). Please try again")
//        return
//      }
//      
//      var myTweets = [Tweet]()
//      let errors: String? = nil
//      myTweets = TweetJSONParser.JSONTweetsFromTwitter(data)
//      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
//        completionHandler(myTweets, errors)
//      })
//    }
//  }
//  
  func userSelectedTweet(ID: String, completionHandler: (String?) -> Void) {
    let selectedTweetURL = self.selectedTweetURL + ID
    let requestURL = NSURL(string: selectedTweetURL)
    let twitterRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
    
    twitterRequest.account = twitterAccount
    twitterRequest.performRequestWithHandler { (data, response, error: NSError?) -> Void in
      if error != nil {
        println(error?.localizedDescription)
        return
      }
      
      let status = (response as NSHTTPURLResponse).statusCode
      let errord = (response as NSHTTPURLResponse).description
      if status != 200 {
        println("Response status \(status). Please try again")
        return
      }
      
      let myTweets = TweetJSONParser.selectedTweetFromJSON(data)!
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        completionHandler(myTweets)
      })
    }
  }
}