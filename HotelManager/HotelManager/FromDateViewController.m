//
//  FromDateViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "FromDateViewController.h"
#import "ToDateViewController.h"

@interface FromDateViewController ()
@end

@implementation FromDateViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.nextButton addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
  self.instructionsLabel.text = @"Select the first date";
}

-(void)nextPressed {
  
  NSDate *selectedDate = self.datePicker.date;
  ToDateViewController *toDateVC = [[ToDateViewController alloc] init];
  toDateVC.startDate = selectedDate;
  [self.navigationController pushViewController:toDateVC animated:true];
}
@end