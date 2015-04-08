//
//  AppDelegate.swift
//  ImageFilters
//
//  Created by Ed Abrahamsen on 4/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    Parse.setApplicationId(kAplicationID,
      clientKey: kClientKey )
    
    let testObject = PFObject(className: "Pizza")
    testObject["Toppings"] = "Cheese"
    testObject.save()
    println("XXXXX")
    return true
  }
}

