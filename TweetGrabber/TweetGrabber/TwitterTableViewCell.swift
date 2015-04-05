//
//  TwitterTableViewCell.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/31/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class TwitterTableViewCell: UITableViewCell {

  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var tweetLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
