//
//  DateValidation.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "DateValidation.h"

@implementation DateValidation

+ (BOOL)validateFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  
  NSComparisonResult comparison = [fromDate compare:toDate];
  if (comparison == NSOrderedAscending || comparison == NSOrderedSame) {
    return true;
  }
  return false;
}
@end