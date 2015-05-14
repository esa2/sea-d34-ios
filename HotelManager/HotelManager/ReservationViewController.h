//
//  ReservationViewController.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface ReservationViewController : UITableViewController

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) NSString *selectedHotel;
@end
