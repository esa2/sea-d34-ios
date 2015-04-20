//
//  UserGitData.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/16/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class UserGitData {
  
  var loginName: String
  var repoAvatarUrl: String
  var repoUrl: String
  var avatarImage: UIImage?
  
  init(loginName: String, repoAvatarUrl: String, repoUrl: String) {
   
    self.loginName = loginName
    self.repoAvatarUrl = repoAvatarUrl
    self.repoUrl = repoUrl
  }
}