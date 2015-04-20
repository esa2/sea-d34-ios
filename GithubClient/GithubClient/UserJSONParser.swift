//
//  UserJSONParser.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/16/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import Foundation

class UserJSONParser {
  
  class func parseJSON(jsonData: NSData) -> [UserGitData] {
    var parse = [UserGitData]()
    var jsonError: NSError?
    
    if let
      jsonDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as? [String: AnyObject],
      dictionaryItems = jsonDictionary["items"] as? [[String: AnyObject]] {
        
      for objects in dictionaryItems {
        if let
          loginName = objects["login"] as? String,
          repoUrl = objects["html_url"] as? String,
          repoAvatarUrl = objects["avatar_url"] as? String {
            let userData = UserGitData(loginName: loginName, repoAvatarUrl: repoAvatarUrl, repoUrl: repoUrl)
            parse.append(userData)
          }
        }
      }
    return parse
  }
}
