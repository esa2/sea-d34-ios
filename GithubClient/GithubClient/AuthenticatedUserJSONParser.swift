//
//  AuthenticatedUserJSONParser.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/17/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import Foundation

class AuthenticatedUserJSONParser {
  
  class func parseJSON(jsonData: NSData) -> AuthenticatedUserGitData {
    
  //  var parse = AuthenticatedUserGitData()
    var gitUserData = AuthenticatedUserGitData(name: "name", location: "location", email: "email")
    var jsonError: NSError?
    
    if let jsonDictionary: AnyObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) {
      println(jsonDictionary)
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
      if let privateRepos: AnyObject? = jsonDictionary["total_private_repos"] {
        gitUserData.privateRepos = privateRepos as? Int
      }
    }
    return gitUserData
  }
}
