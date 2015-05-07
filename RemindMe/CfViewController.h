//
//  CfViewController.h
//  RemindMe
//
//  Created by Ed Abrahamsen on 4/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface CfViewController : UIViewController

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString* city;
@end
