//
//  UserDetailViewController.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/16/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class UserDetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var loginName: UILabel!
  @IBOutlet weak var webButtonTitle: UIButton!
  
  let thumbnailSize = CGSize(width: 100, height: 100)
  var selectedUser: UserGitData!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    webButtonTitle.setTitle(selectedUser.repoUrl, forState: UIControlState.Normal)
    let resizedImage = ImageResizer.resizeImage(selectedUser.avatarImage!, size: thumbnailSize)
    self.imageView.image = resizedImage
    self.loginName.text = "Login name: " + selectedUser.loginName
  }
  
  @IBAction func webButtonPressed(sender: AnyObject) {
    }
}
