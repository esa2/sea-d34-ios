//
//  HotelViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/4/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "HotelViewController.h"
#import "RoomViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Hotel.h"

@interface HotelViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *hotels;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation HotelViewController

-(void)loadView {
  
  UIView *rootView = [[UIView alloc] init];
  self.tableView = [[UITableView alloc] init];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.tableView];
  [self addConstraintsToRootView:rootView withViews:@{@"tableView" : self.tableView}];
  self.view = rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Our hotels";
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  HotelService *hotelService = appDelegate.hotelService;
  self.hotels = [hotelService fetchAllHotels];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.hotels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelCell"forIndexPath:indexPath];
  Hotel *hotel = self.hotels[indexPath.row];
  cell.textLabel.text = hotel.name;
  //cell.textLabel.text = [NSString stringWithFormat: @"Name: %@ Rating: %@", hotel.name, hotel.rating];
  return cell;
}

-(void)addConstraintsToRootView:(UIView *)rootView withViews:(NSDictionary *)views {
  
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVertical];
  NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontal];
  }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  RoomViewController *roomVC = [[RoomViewController alloc] init];
  roomVC.hotel = self.hotels[indexPath.row];
  [self.navigationController pushViewController:roomVC animated:true];
  [tableView deselectRowAtIndexPath:indexPath animated:false];
}
@end