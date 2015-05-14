//
//  Reservation.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/9/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guest, Room;

@interface Reservation : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) Guest *guest;
@property (nonatomic, retain) Room *room;

@end
