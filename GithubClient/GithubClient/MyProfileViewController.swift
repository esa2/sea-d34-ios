//
//  MyProfileViewController.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/18/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class MyProfileViewController: UIViewController {
  
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var hireableLabel: UILabel!
  @IBOutlet weak var publicRepoLabel: UILabel!
  @IBOutlet weak var privateRepoLabel: UILabel!
  
  let githubService = GithubService()
  var selectedUser: AuthenticatedUserGitData!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.githubService.getLoggedInUsersForSearch({ (user, error) -> (Void) in
      
      if user != nil {
        self.selectedUser = user!
        self.nameLabel.text = self.selectedUser.name
        
        if self.selectedUser.location == "" {
          self.locationLabel.text = "No location available"
        } else {
          self.locationLabel.text = self.selectedUser.location
        }
        
        if self.selectedUser.email == "" {
          self.emailLabel.text = "No email available"
        } else {
        self.emailLabel.text = self.selectedUser.email
        }
        
        if self.selectedUser.hireable == true {
          self.hireableLabel.text = "Yes"
        } else {
          self.hireableLabel.text = "No"
        }
        
        if self.selectedUser.publicRepos == nil {
          self.publicRepoLabel.text = "0"
        } else {
        let publicCount: Int = self.selectedUser.publicRepos!
        var publicRepoCount = String(publicCount)
        self.publicRepoLabel.text = publicRepoCount
        }
        
        if self.selectedUser.privateRepos == nil {
          self.privateRepoLabel.text = "0"
          } else {
          let privateCount: Int = self.selectedUser.privateRepos!
          var privateRepoCount = String(privateCount)
          self.privateRepoLabel.text = privateRepoCount
          }
      }
    })
  }
}
