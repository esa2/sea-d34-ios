//
//  RepoJSONParser.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/14/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import Foundation

class RepoJSONParser {
  
  class func parseJSON(jsonData: NSData) -> [RepoGitData] {
    var parse = [RepoGitData]()
    var jsonError: NSError?
    
    if let
      jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as? [String: AnyObject],
      dictionaryItems = jsonDictionary["items"] as? [[String: AnyObject]] {
    
      for objects in dictionaryItems {
        if let
          repoName = objects["name"] as? String,
          ownerDictionary = objects["owner"] as? [String: AnyObject],
          repoUrl = objects["html_url"] as? String {
          let repoData = RepoGitData(repoName: repoName, repoUrl:repoUrl)
            parse.append(repoData)
        }
      }
    }
    return parse
  }
}