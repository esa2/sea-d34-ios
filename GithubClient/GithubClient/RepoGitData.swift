//
//  RepoGitData.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/14/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import Foundation

struct RepoGitData {
  
  var repoName: String
  var repoUrl: String
  
  init(repoName: String, repoUrl: String) {
    self.repoName = repoName
    self.repoUrl = repoUrl
    }
}