//
//  RoomViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/10/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "RoomViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Room.h"

@interface RoomViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *rooms;
@end

@implementation RoomViewController

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
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  HotelService *hotelService = appDelegate.hotelService;
  self.rooms = [hotelService fetchAllRoomsForHotel: self.hotel.name];
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"RoomCell"];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section {
  return self.rooms.count;
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"RoomCell"forIndexPath: indexPath];
  Room *rooms = self.rooms[indexPath.row];
  NSString* roomNumber = [NSString stringWithFormat:@"Room# %@  Beds %@", rooms.number, rooms.beds];
  cell.textLabel.text = roomNumber;
  return cell;
}

-(void)addConstraintsToRootView:(UIView *)rootView withViews:(NSDictionary *)views {
  
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVertical];
  NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontal];
}
@end