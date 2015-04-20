//
//  AuthenticatedUserGitData.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/17/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import Foundation

class AuthenticatedUserGitData {
  
  var hireable: Bool?
  var publicRepos: Int?
  var privateRepos: Int?
  var name: String
  var location: String
  var email: String
  
  init(name: String, location: String, email: String) {
    self.name = name
    self.location = location
    self.email = email
  }
}
