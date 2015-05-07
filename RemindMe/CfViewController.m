//
//  CfViewController.m
//  RemindMe
//
//  Created by Ed Abrahamsen on 4/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "CfViewController.h"

@interface CfViewController () <CLLocationManagerDelegate, GMSMapViewDelegate>
@end

float SEA_CAMERA_HEADING = -80;
double SEA_CAMERA_PITCH = 0;
float SEA_CAMERA_ZOOM = 1;
double SEA_CAMERA_FIELD_OF_VIEW = 90;
int SEA_ROTATE_CAMERA_DURATION = 2;
float POR_CAMERA_HEADING = +110;
double POR_CAMERA_PITCH = 0;
float POR_CAMERA_ZOOM = 1;
double POR_CAMERA_FIELD_OF_VIEW = 90;
int POR_ROTATE_CAMERA_DURATION = 3;
float CHI_CAMERA_HEADING = 0;
double CHI_CAMERA_PITCH = 45;
float CHI_CAMERA_ZOOM = 1;
double CHI_CAMERA_FIELD_OF_VIEW = 90;
int CHI_ROTATE_CAMERA_DURATION = 2;


@implementation CfViewController {
  GMSPanoramaView *panoView;
  GMSCameraPosition *cameraPosition;
  GMSMapView *mapView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  panoView = [[GMSPanoramaView alloc] initWithFrame:CGRectZero];
  self.view = panoView;
  [panoView moveNearCoordinate: self.coordinate];
}

-(void)viewDidAppear:(BOOL)animated {
  
  if ([self.city  isEqual: @"Sea"]) {
    GMSPanoramaCamera *camera =
    [GMSPanoramaCamera cameraWithHeading: SEA_CAMERA_HEADING pitch: SEA_CAMERA_PITCH zoom: SEA_CAMERA_ZOOM FOV: SEA_CAMERA_FIELD_OF_VIEW];
    [panoView animateToCamera: (camera) animationDuration: SEA_ROTATE_CAMERA_DURATION];
    
  } else if ([self.city isEqualToString:@"Por"]) {
    GMSPanoramaCamera *camera =
    [GMSPanoramaCamera cameraWithHeading: POR_CAMERA_HEADING pitch: POR_CAMERA_PITCH zoom: POR_CAMERA_ZOOM FOV: POR_CAMERA_FIELD_OF_VIEW];
    [panoView animateToCamera: (camera) animationDuration: POR_ROTATE_CAMERA_DURATION];
    
  } else {
    GMSPanoramaCamera *camera =
    [GMSPanoramaCamera cameraWithHeading: CHI_CAMERA_HEADING pitch: CHI_CAMERA_PITCH zoom: CHI_CAMERA_ZOOM FOV: CHI_CAMERA_FIELD_OF_VIEW];
    [panoView animateToCamera: (camera) animationDuration: CHI_ROTATE_CAMERA_DURATION];
  }
}
@end
