//
//  AddReminderViewController.h
//  RemindMe
//
//  Created by Ed Abrahamsen on 5/4/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddReminderViewController: UIViewController

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong,nonatomic) CLLocationManager *locationManager;
@end