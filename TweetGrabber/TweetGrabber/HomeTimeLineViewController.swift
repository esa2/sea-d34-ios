//
//  HomeTimeLineViewController.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class HomeTimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var tweets:[Tweet]?
  let getMyTweets = GetMyTweets()
  let getImages = GetImages()
  let homeTimelineURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: "TweetDisplayCell", bundle: NSBundle.mainBundle())
    self.tableView.registerNib(nib, forCellReuseIdentifier: "TweetCell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.estimatedRowHeight = 50
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.navigationController?.hidesBarsOnSwipe = true
    self.activityIndicator.hidesWhenStopped = true
    self.activityIndicator.startAnimating()
    self.tableView.userInteractionEnabled = false
    
   GetAccount.AccountTypeTwitter { (twitterAccount, errorDescription) -> Void in
      if twitterAccount != nil {
          GetMyTweets.sharedGetTweets.twitterAccount = twitterAccount
          let requestURL = NSURL(string: self.homeTimelineURL)
          
          GetMyTweets.sharedGetTweets.fetchHomeTimelineUser(requestURL!, { (tweets, errorDescription) -> Void in
            if errorDescription != nil {
            println(errorDescription)
            return
            }

            if tweets != nil {
              self.tweets = tweets
              self.tableView.reloadData()
              self.title = "Tweet Grabber"
              self.tableView.userInteractionEnabled = true
              self.activityIndicator.stopAnimating()
            }
          })
        }
      }
    }
  
  func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
    if let tweetCount = self.tweets?.count {
      return tweetCount
    }
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as TwitterTableViewCell
    cell.tag++
    let cellTag = cell.tag
    cell.textLabel?.text = nil
    
    if let tweet = self.tweets?[indexPath.row] {
      cell.nameLabel?.text = "User " + "\""  + tweet.name + "\"" + " wrote:"
      cell.tweetLabel?.text = tweet.text
      cell.userImageView?.image = tweet.image
        
      if let image = tweet.image {
        cell.userImageView.image = image
      } else {
        self.getImages.getUserImages(tweet.imageURL, completionHandler: { [weak self] (image) -> () in
          if self != nil {
            tweet.image = image
            if cellTag == cell.tag {
              cell.userImageView.image = tweet.image
            }
          }
        })
      }
    }
    cell.layoutIfNeeded()
      return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("TweetInfoVC") as SelectedTweetViewController
    let selectedTweet = self.tweets![indexPath.row]
    viewController.selectedTweet = selectedTweet
      
    self.navigationController?.pushViewController(viewController, animated: false)
    self.title = "Home"
   }
}