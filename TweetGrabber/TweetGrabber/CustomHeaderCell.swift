//
//  CustomHeaderCell.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 4/4/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import UIKit

class CustomHeaderCell: UITableViewCell {

 
  
  @IBOutlet weak var backgroungImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var handleLabel: UILabel!
  @IBOutlet weak var bioLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
