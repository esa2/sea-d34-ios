//
//  TimeLineViewController.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class TimeLineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet var tableView: UITableView!
  
  var parseImages: [UIImage]! = []
  var timeLineImage: UIImage!
  let thumbnailSize = CGSize(width: 75, height: 75)
  let estimatedSizeOfImage: CGFloat = 167.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
   }
  
  override func viewWillAppear(animated: Bool) {
    self.tableView.estimatedRowHeight = estimatedSizeOfImage
    self.tableView.rowHeight = UITableViewAutomaticDimension
    
    ParseService.queryImageObjects({ (data, error) -> Void in
      if let images = data {
        println("image coming back")
        self.parseImages = images
        self.tableView.reloadData()
      }
    })
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  println(self.parseImages.count)
  return parseImages.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! TimeLineCell
    var parseImage = self.parseImages[indexPath.row]
    cell.timeLineImage.image = parseImage
    return cell
  }
}