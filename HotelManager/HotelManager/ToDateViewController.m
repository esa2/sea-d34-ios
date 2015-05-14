//
//  ToDateViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "ToDateViewController.h"
#import "AvailabilityViewController.h"

@interface ToDateViewController ()
@end

@implementation ToDateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.instructionsLabel.text = @"Select end date";
  [self.nextButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)nextPressed {
  
  NSDate *selectedDate = self.datePicker.date;
  AvailabilityViewController *availabilityVC = [[AvailabilityViewController alloc] init];
  availabilityVC.startDate = self.startDate;
  availabilityVC.endDate = selectedDate;
  [self.navigationController pushViewController:availabilityVC animated:true];
}
@end