//
//  WebViewController.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/17/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit
import WebKit

class WebViewController: UIViewController {

  @IBOutlet weak var webView: UIWebView!
  
  var selectedRepo: RepoGitData!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let url = NSURL(string: selectedRepo.repoUrl)
    let request = NSURLRequest(URL: url!)
    
    webView.loadRequest(request)
  }
}
