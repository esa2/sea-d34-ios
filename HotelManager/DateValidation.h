//
//  DateValidation.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface DateValidation : NSObject

+ (BOOL)validateFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
@end
