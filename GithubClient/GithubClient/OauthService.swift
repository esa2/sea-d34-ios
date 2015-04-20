//
//  OauthService.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/15/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class OAuthService {
  
  var oauthRequestCompletionHandler: (() -> ())?
  
  func requestOAuth(completionHandler: () -> ()) {
    self.oauthRequestCompletionHandler = completionHandler
    let initialOAuthURL = "https://github.com/login/oauth/authorize?client_id=\(kGithubClientKey)&scope=user,public_repo"
    UIApplication.sharedApplication().openURL(NSURL(string: initialOAuthURL)!)
  }
  
  func handleRedirect(url: NSURL) {
    let code = url.query // after github returns to app their stuff here
    let url = "https://github.com/login/oauth/access_token"
    let parameters = "\(code!)&client_id=\(kGithubClientKey)&client_secret=\(kGithubSecretKey)"
    let data = parameters.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
    
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    request.HTTPMethod = "POST"
    request.HTTPBody = data
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("\(data!.length)", forHTTPHeaderField: "Content-Length") // set length so server knows if something dropped or added
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in   //completionhandel is callback in the closure that fires at completion
      
      if error == nil {
        if let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject] {
          let token = jsonDictionary["access_token"] as! String
          
          NSUserDefaults.standardUserDefaults().setObject(token, forKey: "githubToken")
          NSUserDefaults.standardUserDefaults().synchronize()
          
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.oauthRequestCompletionHandler!()
          })
        }
      }
    })
    dataTask.resume()
  }
}

