//
//  AllUserTweetsViewController.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 4/4/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class AllUserTweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var tweets:[Tweet]?
  let getMyTweets = GetMyTweets()
  let getImages = GetImages()
  var name = ""
  var handle = ""
  var bio = ""
  var screenName = ""
  var backgroundImageURL = ""
  var location = ""
  var allTweetsURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name="
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nib = UINib(nibName: "TweetDisplayCell", bundle: NSBundle.mainBundle())
    self.tableView.registerNib(nib, forCellReuseIdentifier: "TweetCell")
    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.tableView.estimatedRowHeight = 4
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.userInteractionEnabled = false
    self.activityIndicator.hidesWhenStopped = true
    self.activityIndicator.startAnimating()
    self.navigationController?.hidesBarsOnSwipe = true
    
    allTweetsURL = self.allTweetsURL + self.screenName
    let requestURL = NSURL(string: allTweetsURL)
    
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
  
  func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as CustomHeaderCell
    
    let url = NSURL(string: backgroundImageURL )
    let imageData = NSData(contentsOfURL: url!)
    headerCell.backgroungImage.image = UIImage(data: imageData!)
    
    let screenName = "@" + self.screenName
    headerCell.nameLabel.text = self.name
    headerCell.handleLabel.text = screenName
    headerCell.bioLabel.text = self.bio
    headerCell.locationLabel.text = self.location
    return headerCell
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
}