//
//  ReservationLookupViewController.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/10/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guest.h"
#import "Reservation.h"

@interface ReservationLookupViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate> {
  
  NSMutableArray *searchData;
  UISearchBar *searchBar;
}

@property (strong, nonatomic) Reservation *reservation;
@end
