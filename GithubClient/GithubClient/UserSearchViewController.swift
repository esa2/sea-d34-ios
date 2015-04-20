//
//  UserSearchViewController.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/16/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class UserSearchViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  let thumbnailSize = CGSize(width: 75, height: 75  )
  let imageDownloadService = ImageDownloadService()
  var users = [UserGitData]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView.dataSource = self
    self.searchBar.delegate = self
    self.navigationController?.delegate = self
    }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.delegate = self
  }
  
  override func viewWillDisappear(animated: Bool) {
    self.navigationController?.delegate = nil
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    GithubService.sharedInstance.getUsersForSearch(searchBar.text, completionHandler: { (users, error) -> (Void) in
      self.users = users!
      self.collectionView.reloadData()
    })
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.regexValidate()
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.users.count
   }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UserCell", forIndexPath: indexPath) as! UserSearchCell
    cell.imageView.image = nil
    let user = self.users[indexPath.row]
    
    if user.avatarImage != nil {
      cell.imageView.image = user.avatarImage
     } else {
      self.imageDownloadService.downloadImageForURL(user.repoAvatarUrl, completionHandler: { (downloadedImage) -> (Void) in
        let resizedImage = ImageResizer.resizeImage(downloadedImage!, size: self.thumbnailSize)
  //     cell.imageView.alpha = 0
  //     cell.imageView.transform = CGAffineTransformMakeScale(2.0, 2.0)
          user.avatarImage = resizedImage
          cell.imageView.image = resizedImage
  //     UIView.animateWithDuration(0.4, animations: { () -> Void in
  //     cell.imageView.alpha = 1
  //     cell.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)
  //     })
      })
    }
    
    
    return cell
  }
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    if toVC is UserDetailViewController {
      return ToUserDetailViewController()
    }
    return nil
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowUser" {
      let destination = segue.destinationViewController as! UserDetailViewController
      let indexPath = self.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      let user = self.users[indexPath.row]
      destination.selectedUser = user
    }
  }
}