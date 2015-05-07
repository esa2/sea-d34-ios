//
//  MapInterfaceController.m
//  RemindMe
//
//  Created by Ed Abrahamsen on 5/5/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "MapInterfaceController.h"

@interface MapInterfaceController ()
@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapView;
@end

@implementation MapInterfaceController

- (void)awakeWithContext:(id)context {
  [super awakeWithContext:context];
  
  CLLocationCoordinate2D cfLocation;
  CLLocationDistance cfSpan;
  cfLocation.latitude = 47.6235481;
  cfLocation.longitude= -122.336212;
  cfSpan = 1000;
  
  MKCoordinateRegion cfView = MKCoordinateRegionMakeWithDistance(cfLocation, cfSpan, cfSpan);
  [self.mapView setRegion: cfView];
  }

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
@end
