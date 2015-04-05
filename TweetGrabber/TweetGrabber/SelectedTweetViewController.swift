//
//  SelectedTweetViewController.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 4/2/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class SelectedTweetViewController: UIViewController {
 
  @IBOutlet weak var selectedTextLabel: UILabel!
  @IBOutlet weak var tweetOwnerButton: UIButton!
  
  var selectedTweet: Tweet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tweetOwnerButton.setBackgroundImage(selectedTweet.image, forState: UIControlState.Normal)
 
    GetMyTweets.sharedGetTweets.userSelectedTweet(self.selectedTweet.ID, completionHandler: { [weak self] (fullText) -> Void in
      if self != nil {
        self!.selectedTextLabel.text = fullText
      }
    })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "AllUsersTweets" {
    let allUserTweetsViewController = segue.destinationViewController as AllUserTweetsViewController
      
    var name = self.selectedTweet.name
    allUserTweetsViewController.name = name
    var bio = self.selectedTweet.description
    allUserTweetsViewController.bio = bio
    var screenName = self.selectedTweet.screenName
    allUserTweetsViewController.screenName = screenName
    var backgroundImageURL = self.selectedTweet.backgroundImageURL
    allUserTweetsViewController.backgroundImageURL = backgroundImageURL
    var location = self.selectedTweet.location
    allUserTweetsViewController.location = location
    }
  }
}