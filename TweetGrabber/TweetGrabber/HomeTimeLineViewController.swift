//
//  HomeTimeLineViewController.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class HomeTimeLineViewController: UIViewController, UITableViewDataSource {

   @IBOutlet var tableView: UITableView!
  
   var tweets:[Tweet]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    
    if let filePath = NSBundle.mainBundle().pathForResource("tweet", ofType: "json") {
      if let data = NSData(contentsOfFile: filePath) {
        self.tweets = TweetJSONParser.JSONTweetsFromTwitter(data)
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
      
      var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as UITableViewCell
      
        if let tweet = self.tweets?[indexPath.row] {
        cell.textLabel?.text = "User " + "\""  + tweet.name + "\"" + " wrote:"
        cell.detailTextLabel?.text = tweet.text
        cell.backgroundColor = UIColor.yellowColor()
      }
      return cell
    }
}