//
//  MapViewController.m
//  RemindMe
//
//  Created by Ed Abrahamsen on 4/30/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "MapViewController.h"
#import "AddReminderViewController.h"
#import "AppDelegate.h"
#import "CfViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>

@interface MapViewController () <CLLocationManagerDelegate, GMSMapViewDelegate>
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UIView *displayedInfoWindow;
@property (strong, nonatomic) GMSMarker *currentlyTappedMarker;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic) CLLocationCoordinate2D seguePos;
@end

float ZOOM = 3;
float US_LAT = 38.4987789;
float US_LON = -98.3200779;
float SEA_LAT = 47.623504;
float SEA_SLON = -122.335819;
float POR_LAT = 45.516441;
float POR_LON = -122.676147;
float CHI_LAT = 41.887956;
float CHI_LON = -87.635473;
float WINDOW_FRAME_X = 20;
float WINDOW_FRAME_Y = 80;
float WINDOW_WIDTH = 220;
float WINDOW_HEIGHT = 40;
float LABEL_FRAME_X = 10;
float LABEL_FRAME_Y = 5;
float LABEL_WIDTH = 70;
float LABEL_HEIGHT = 30;
float BUTTON_FRAME_X = 90;
float BUTTON_FRAME_Y = 5;
float BUTTON_WIDTH = 150;
float BUTTON_HEIGHT = 30;

@implementation MapViewController {
  
GMSMapView *mapView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(regionAdded:) name: @"RegionAdded" object: nil];
  
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  self->mapView.delegate = self;
  
  if ([CLLocationManager locationServicesEnabled]) {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
      [self.locationManager requestAlwaysAuthorization];
      self->mapView.myLocationEnabled = YES;
    }
  }
  
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude: US_LAT longitude: US_LON zoom: ZOOM];
  mapView = [GMSMapView mapWithFrame: CGRectZero camera: camera];
  
  mapView.myLocationEnabled = YES;
  mapView.settings.compassButton = YES;
  mapView.settings.myLocationButton = YES;
  self.view = mapView;
  
  CLLocationCoordinate2D seattlePosition = CLLocationCoordinate2DMake(SEA_LAT, SEA_SLON);
  GMSMarker *seattleMarker = [GMSMarker markerWithPosition: seattlePosition];
  seattleMarker.title = @"Go Hawks";
  seattleMarker.map = mapView;
  seattleMarker.icon = [UIImage imageNamed:@"cfLogo2"];
  
  CLLocationCoordinate2D portlandPosition = CLLocationCoordinate2DMake(POR_LAT, POR_LON);
  GMSMarker *portlandMarker = [GMSMarker markerWithPosition: portlandPosition];
  portlandMarker.title = @"Super Chargers";
  portlandMarker.map = mapView;
  portlandMarker.icon = [UIImage imageNamed:@"cfLogo2"];
  
  CLLocationCoordinate2D chicagoPosition = CLLocationCoordinate2DMake(CHI_LAT, CHI_LON);
  GMSMarker *chicagoMarker = [GMSMarker markerWithPosition: chicagoPosition];
  chicagoMarker.title = @"Da Bears";
  chicagoMarker.map = mapView;
  chicagoMarker.icon = [UIImage imageNamed:@"cfLogo2"];
  mapView.delegate = self;
  
  NSString *path = [NSString stringWithFormat:@"%@/c2.mp3", [[NSBundle mainBundle] resourcePath]];
  NSURL *soundUrl = [NSURL fileURLWithPath:path];
  _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
}

-(void)regionAdded:(NSNotification *)notification {
  NSDictionary *userInfo = notification.userInfo;
  CLCircularRegion *region = userInfo[@"region"];
  GMSCircle *circle = [GMSCircle circleWithPosition: region.center radius: region.radius];
  circle.map = mapView;
  circle.fillColor = [UIColor colorWithRed:0.25 green:0 blue:0.25 alpha:0.05];
  circle.strokeColor = [UIColor redColor];
  circle.strokeWidth = 5;
  self.view = mapView;
  }

-(void)locationManager:(CLLocationManager *)manager didEnterRegion :(CLRegion *)region {
  UILocalNotification *notification = [[UILocalNotification alloc] init];
  notification.alertBody = @"Entring region";
  notification.alertTitle = [NSString stringWithFormat: @"You are close to %@", region.identifier];
  notification.alertAction = @"region launch";
  [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

-(void)locationManager:(CLLocationManager *)manager didexitRegion :(CLRegion *)region {
  UILocalNotification *notification = [[UILocalNotification alloc] init];
  notification.alertBody = @"Leaving region";
  notification.alertTitle = [NSString stringWithFormat: @"You are putting it all behind you %@", region.identifier];
  notification.alertAction = @"region launch";
  [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  CLLocation *firstLocation = locations.firstObject;
  NSLog(@"%f, %f", firstLocation.coordinate.latitude, firstLocation.coordinate.longitude);
}

- (void)enableMyLocation {
  CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
  if (status == kCLAuthorizationStatusNotDetermined)
    [self requestLocationAuthorization];
  else if (status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted)
    return;
  else
    mapView.settings.myLocationButton = YES;
    mapView.myLocationEnabled = YES;
  }

- (void)requestLocationAuthorization {
  _locationManager = [[CLLocationManager alloc] init];
  _locationManager.delegate = self;
  [_locationManager requestAlwaysAuthorization];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
  if (status == kCLAuthorizationStatusAuthorizedAlways) {
  }
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
  NSLog(@"Tap at %f,%f", coordinate.latitude, coordinate.longitude);
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
  self.seguePos = coordinate;

  if([self.displayedInfoWindow isDescendantOfView:self.view]) {
    [self.displayedInfoWindow removeFromSuperview];
    self.displayedInfoWindow = nil;
  }
  
  GMSMarker *boltMarker = [GMSMarker markerWithPosition: coordinate];
  self.currentlyTappedMarker = boltMarker;
  boltMarker.icon = [UIImage imageNamed:@"bolt1"];
  boltMarker.map = self->mapView;
  boltMarker.draggable = YES;
  boltMarker.tappable = YES;
  [_audioPlayer play];
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
  
  if ([marker.title  isEqual: @"Go Hawks"]) {
    
    CfViewController *cityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CityVC"];
    CLLocationCoordinate2D seattlePosition = CLLocationCoordinate2DMake(SEA_LAT, SEA_SLON);
    cityVC.coordinate = seattlePosition;
    cityVC.city = @"Sea";
    cityVC.locationManager = self.locationManager;
    [self.navigationController pushViewController :cityVC animated:YES];
    
  } else if ([marker.title  isEqual: @"Super Chargers"]) {
    
    CfViewController *cityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CityVC"];
    CLLocationCoordinate2D portlandPosition = CLLocationCoordinate2DMake(POR_LAT, POR_LON);
    cityVC.coordinate = portlandPosition;
    cityVC.city = @"Por";
    cityVC.locationManager = self.locationManager;
    [self.navigationController pushViewController :cityVC animated:YES];
    
  } else if ([marker.title  isEqual: @"Da Bears"]) {
    
    CfViewController *cityVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CityVC"];
    CLLocationCoordinate2D chicagoPosition = CLLocationCoordinate2DMake(CHI_LAT, CHI_LON);
    cityVC.coordinate = chicagoPosition;
    cityVC.city = @"Chi";
    cityVC.locationManager = self.locationManager;
    [self.navigationController pushViewController :cityVC animated:YES];
    
  } else {
    
    self.displayedInfoWindow = [[UIView alloc] init];
    self.displayedInfoWindow.backgroundColor = [UIColor blueColor];
    
    CGPoint markerPoint = [self->mapView.projection pointForCoordinate: self.currentlyTappedMarker.position];
    self.displayedInfoWindow.frame = CGRectMake(WINDOW_FRAME_X, markerPoint.y - WINDOW_FRAME_Y, WINDOW_WIDTH, WINDOW_HEIGHT);
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(LABEL_FRAME_X, LABEL_FRAME_Y, LABEL_WIDTH, LABEL_HEIGHT);
    label.textColor = [UIColor whiteColor];
    label.text = @("Go bolts");
    [self.displayedInfoWindow addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(BUTTON_FRAME_X, BUTTON_FRAME_Y, BUTTON_WIDTH, BUTTON_HEIGHT);
    [button setTitle:@"Add reminder?" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.displayedInfoWindow addSubview:button];
    [self.view addSubview:self.displayedInfoWindow];
  }
  return true;
}

- (void)buttonClicked:(id)sender {
  
 AddReminderViewController *addVC = [self.storyboard instantiateViewControllerWithIdentifier: @"AddVC"];
  addVC.coordinate = self.seguePos;
  addVC.locationManager = self.locationManager;
  [self.displayedInfoWindow removeFromSuperview];
  [self.navigationController pushViewController :addVC animated:YES];
}

- (IBAction)mapTypePressed:(UISegmentedControl *)sender {
  
  switch (sender.selectedSegmentIndex) {
    case 0: {
      mapView.mapType = kGMSTypeNormal;
      break;
    }
    case 1: {
      mapView.mapType = kGMSTypeSatellite;
      break;
    }
    case 2: {
      mapView.mapType = kGMSTypeHybrid;
    }
  }
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end