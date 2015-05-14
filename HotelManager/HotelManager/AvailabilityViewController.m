//
//  AvailabilityViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "ReservationViewController.h"
#import "AppDelegate.h"
#import "Room.h"
#import "Hotel.h"
#import "HotelService.h"

@interface AvailabilityViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

CGFloat labelHeight = 20;

@implementation AvailabilityViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.title = @"Available rooms";
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"roomCell"];
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
  self.fetchedResultsController = [appDelegate.hotelService fetchedResultsForAvailableRooms:self.startDate toDate:self.endDate];
  self.fetchedResultsController.delegate = self;
  NSError *fetchError;
  [NSFetchedResultsController deleteCacheWithName:self.fetchedResultsController.cacheName];
  [self.fetchedResultsController performFetch:&fetchError];
  [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if ([[self.fetchedResultsController sections] count] > 0) {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
  } else
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomCell"];
  [self configureCell:cell forIndexPath:indexPath];
  return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
  Room *room = [self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = [[NSString alloc] initWithFormat:@"Room#: %@  Beds: %@ Price: $%@",room.number, room.beds, room.rate];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section  {
  
  id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
  Room *room = (Room *)sectionInfo.objects[0];
  Hotel *hotel = room.hotel;
  NSString *description = [[NSString alloc] initWithFormat:@"%@ - %@", hotel.name, hotel.location];
  return description;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  ReservationViewController *reservationVC = [[ReservationViewController alloc] init];
  reservationVC.startDate = self.startDate;
  reservationVC.endDate = self.endDate;
  Room *room = [self.fetchedResultsController objectAtIndexPath:indexPath];
  reservationVC.room = room;
  reservationVC.selectedHotel = room.hotel.name;
  
  [self.tableView deselectRowAtIndexPath:indexPath animated:false];
  [self.navigationController pushViewController:reservationVC animated:true];
}
@end