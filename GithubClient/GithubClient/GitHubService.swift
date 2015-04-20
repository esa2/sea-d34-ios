//
//  GitHubService.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/14/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import Foundation

class GithubService {
  
  static let sharedInstance: GithubService = GithubService()
  let goodHttpResponse = 200
  
  // let localUrl = "http://127.0.0.1:3000"
  
  func getReposForSearch(searchTerm: String, completionHandler: ([RepoGitData]?, String?) ->(Void)) {
    
    let githubSearchRepoUrl = "https://api.github.com/search/repositories"
    let queryString = "?q=\(searchTerm)"
    let requestUrl = githubSearchRepoUrl + queryString
    println(requestUrl)
    let url = NSURL(string: requestUrl)
    let request = NSURLRequest(URL: url!)
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      
      if let httpResponse = response as? NSHTTPURLResponse {
        println(httpResponse.statusCode)
        if httpResponse.statusCode == self.goodHttpResponse {
          let parsedRepo = RepoJSONParser.parseJSON(data)
          
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(parsedRepo, nil)
          })
        }
      }
    })
    dataTask.resume()
  }
  
  func getUsersForSearch(search: String, completionHandler : ([UserGitData]?, String?) -> (Void)) {
    
    let searchUrl = "https://api.github.com/search/users?q="
    let url = searchUrl + search
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    if let token = NSUserDefaults.standardUserDefaults().objectForKey("githubToken") as? String {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
    let users = UserJSONParser.parseJSON(data)
      
      if let httpResponse = response as? NSHTTPURLResponse {
        println(httpResponse.statusCode)
        if httpResponse.statusCode == self.goodHttpResponse {

          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(users, nil)
          })
        }
      }
    })
    dataTask.resume()
  }
  
  func getLoggedInUsersForSearch(completionHandler : (AuthenticatedUserGitData?, String?) -> (Void)) {
    
    let userUrl = "https://api.github.com/user"
    let request = NSMutableURLRequest(URL: NSURL(string: userUrl)!)
    if let token = NSUserDefaults.standardUserDefaults().objectForKey("githubToken") as? String {
      request.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      let user = AuthenticatedUserJSONParser.parseJSON(data)
      
      if let httpResponse = response as? NSHTTPURLResponse {
        if httpResponse.statusCode == self.goodHttpResponse {

          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            completionHandler(user, nil)
          })
        }
      }
    })
  dataTask.resume()
  }
}
