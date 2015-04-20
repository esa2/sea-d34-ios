//
//  RepoSearchViewController.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/14/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class RepoSearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let githubService = GithubService()
  var repos = [RepoGitData]()
  
  override func viewDidLoad() {
        super.viewDidLoad()

    self.tableView.dataSource = self
    self.tableView.delegate = self
    self.searchBar.delegate = self
  }
 
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.repos.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("RepoNameCell", forIndexPath: indexPath) as! UITableViewCell
    let repoData = self.repos[indexPath.row]
    cell.textLabel?.text = repoData.repoName
    cell.textLabel?.textColor = UIColor.blueColor()
    return cell
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    self.githubService.getReposForSearch(searchBar.text, completionHandler: { (repos, error) -> (Void) in
      if repos != nil {
        self.repos = repos!
        self.tableView.reloadData()
      }
    })
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.regexValidate()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "WebView" {
      let destination = segue.destinationViewController as! WebViewController
      let indexPath = self.tableView.indexPathForSelectedRow()
      let repo = self.repos[indexPath!.row]
      destination.selectedRepo = repo
    }
  }
}



