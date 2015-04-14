//
//  AppDelegate.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Parse.setApplicationId(kAplicationID,
      clientKey: kClientKey )
    return true
  }
}