//
//  LoggedInUserJSONParser.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/17/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import Foundation

class LoggedInUserJSONParser {
  
  class func parseJSON(jsonData: NSData) -> LoggedInUserGitData {
    
  //  var parse = LoggedInUserGitData()
    var gitUserData = LoggedInUserGitData(name: "name", location: "location", email: "email")
    var jsonError: NSError?
    
    if let jsonDictionary: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) {
      if let name: AnyObject? = jsonDictionary["name"] {
        gitUserData.name = name as! String
      }
      
      if let location: AnyObject? = jsonDictionary["location"] {
        gitUserData.location = location as! String
       }
      
      if let email: AnyObject? = jsonDictionary["email"] {
        gitUserData.email = email as! String
       }
      
      if let hireable: AnyObject? = jsonDictionary["hireable"] {
        gitUserData.hireable = hireable as? Bool
      }
      
      if let publicRepos: AnyObject? = jsonDictionary["public_repos"] {
        gitUserData.publicRepos = publicRepos as? Int
      }
    }
    return gitUserData
  }
}
