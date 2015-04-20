//
//  StringExtension.swift
//  GithubClient
//
//  Created by Ed Abrahamsen on 4/17/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
import Foundation
import AVFoundation

var player:AVAudioPlayer = AVAudioPlayer()

extension String {
  
  func regexValidate() -> Bool {
    let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n]", options: nil, error: nil)
    let elements = count(self)
    let range = NSMakeRange(0, elements)
    let matches = regex?.numberOfMatchesInString(self, options: nil, range: range)
    
    if matches > 0 {
      var fileLocation = NSString(string: NSBundle.mainBundle().pathForResource("uhoh", ofType: "mp3")!)
      var error: NSError? = nil
      player = AVAudioPlayer(contentsOfURL: NSURL(string: fileLocation as String), error: &error)
      player.play()
      return false
    }
    return true
  }
}


