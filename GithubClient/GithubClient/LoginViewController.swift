//
//  LoginViewController.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/15/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var eyeImageView: UIImageView!
  @IBOutlet weak var heartImageView: UIImageView!
  @IBOutlet weak var gitIconView: UIImageView!
  @IBOutlet weak var arrowImageView: UIImageView!
  @IBOutlet weak var loginButton: UIButton!
  
  let moveOnOffView: CGFloat = 400
  let animateWithShortDuration = 0.8
  let animateWithLongDuration = 2.0
  let matrixFactor: CGFloat = 1.2
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    heartImageView.image = UIImage(named: "heart.png")
    gitIconView.image = UIImage(named: "githubicon.png")
    eyeImageView.image = UIImage(named: "eye.png")
    arrowImageView.image = UIImage(named: "arrow.jpeg")
    
    self.loginButton.center = CGPointMake(self.loginButton.center.x + self.moveOnOffView, self.loginButton.center.y)
    self.loginButton.alpha = 0
    
    self.arrowImageView.center = CGPointMake(self.arrowImageView.center.x - self.moveOnOffView, self.arrowImageView.center.y)
    self.arrowImageView.alpha = 0
    
    heartBeat()
    showLoginButton()
    showArrow()
  }
  
  func heartBeat() {
    
    UIView.animateWithDuration(animateWithShortDuration, animations: {
      self.heartImageView.transform = CGAffineTransformMakeScale(self.matrixFactor, self.matrixFactor) }, completion: { finished in
        UIView.animateWithDuration(self.animateWithShortDuration, animations: {
          self.heartImageView.transform = CGAffineTransformMakeScale(1.0, 1.0) }, completion: { finished in
            self.heartBeat()
        })
    })
  }
  
  func showLoginButton() {
    UIView.animateWithDuration(animateWithLongDuration, animations: {
      self.loginButton.alpha = 1
      self.loginButton.center = CGPointMake(self.loginButton.center.x - self.moveOnOffView, self.loginButton.center.y)
    })
  }
  
  func showArrow() {
    UIView.animateWithDuration(1, animations: {
      self.arrowImageView.alpha = 1
      self.arrowImageView.center = CGPointMake(self.arrowImageView.center.x + self.moveOnOffView, self.arrowImageView.center.y)
    })
  }

  @IBAction func loginButtonPressed(sender: AnyObject) {
    
    let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let oauthService = appdelegate.oauthService
    oauthService.requestOAuth { [weak self] () -> () in
    
      if self != nil {
        let window = appdelegate.window
        let navController = self?.storyboard?.instantiateViewControllerWithIdentifier("MainMenuView") as! UINavigationController
        UIView.transitionFromView(self!.view, toView: navController.view, duration: self!.animateWithLongDuration, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: { (finished) -> Void in
          if finished {
          window?.rootViewController = navController
          }
        })
      }
    }
  }
}