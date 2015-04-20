//
//  ToUserDetailViewController.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/16/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class ToUserDetailViewController: NSObject, UIViewControllerAnimatedTransitioning {

  let duration = 0.3
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.3
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UserSearchViewController
    let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! UserDetailViewController
    let containerView = transitionContext.containerView()
    
    toVC.view.alpha = 0
    containerView.addSubview(toVC.view)
    
    let selectedIndexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
    let userCell = fromVC.collectionView.cellForItemAtIndexPath(selectedIndexPath) as! UserSearchCell
    let snapShot = userCell.imageView.snapshotViewAfterScreenUpdates(false)
    userCell.hidden = true
    snapShot.frame = containerView.convertRect(userCell.imageView.frame, fromCoordinateSpace: userCell.imageView.superview!)
    containerView.addSubview(snapShot)
    toVC.view.layoutIfNeeded()  //force storyboard constraints to be used, need this because not in viewdidload
    
    let frame = containerView.convertRect(toVC.imageView.frame, fromView: toVC.view)
    toVC.imageView.hidden = true
    
    UIView.animateWithDuration(duration, animations: { () -> Void in
      toVC.view.alpha = 1
      snapShot.frame = frame
    })
      { (finished) -> Void in
      if finished {
        toVC.imageView.hidden = false
        snapShot.removeFromSuperview()
        userCell.hidden = false
        transitionContext.completeTransition(true)
      } else {
        transitionContext.completeTransition(false)
      }
    }
  }
}