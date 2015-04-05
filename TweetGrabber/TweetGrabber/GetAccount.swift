//
//  GetAccount.swift
//  TweetGrabber
//
//  Created by Ed Abrahamsen on 3/31/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

import Foundation
import Accounts

class GetAccount {

  class func AccountTypeTwitter(completionHandler: (ACAccount?, String?) -> Void) {
  
    let account = ACAccountStore()
    let typeTwitter = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)

    account.requestAccessToAccountsWithType(typeTwitter, options: nil) { (granted, error) -> Void in
      if granted && error == nil {
        if let requestedAccount = account.accountsWithAccountType(typeTwitter) as? [ACAccount] {
          if !requestedAccount.isEmpty {
            let twitterAccount = requestedAccount.first
            completionHandler(twitterAccount, nil)
          }
        }
      } else {
        completionHandler(nil, "Please sign in to your twitter account")
      }
    }
  }
}