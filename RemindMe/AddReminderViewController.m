//
//  AddReminderViewController.m
//  RemindMe
//
//  Created by Ed Abrahamsen on 5/4/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "AddReminderViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface AddReminderViewController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *reminderName;
@end

@implementation AddReminderViewController

float METERS = 200;

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)addRegionPressed:(id)sender {
  
  if ([self.reminderName.text isEqualToString:@""]) {
    
  } else if ( [CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter: self.coordinate radius: METERS identifier: self.reminderName.text];
    [self.locationManager startMonitoringForRegion:region];
    NSDictionary *userInfo = @{@"region": region};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegionAdded" object:self userInfo: userInfo];
    [self.navigationController popViewControllerAnimated:YES];
  }
}

-(BOOL)textFieldShouldReturn: (UITextField *)textField {
  [textField resignFirstResponder];
  return true;
}
@end