//
//  AvailabilityViewController.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailabilityViewController : UITableViewController

@property (strong,nonatomic) NSDate *startDate;
@property (strong,nonatomic) NSDate *endDate;
@end
