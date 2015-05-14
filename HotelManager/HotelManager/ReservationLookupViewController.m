//
//  ReservationLookupViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/10/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "ReservationLookupViewController.h"
#import "HotelService.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "Guest.h"
#import "Hotel.h"

@interface ReservationLookupViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating>
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *guests;
@property (strong,nonatomic) NSArray *reservations;
@property (strong,nonatomic) NSArray *hotels;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) UISearchController *searchController;
@end

@implementation ReservationLookupViewController

-(void)loadView {
  
  UIView *rootView = [[UIView alloc] init];
  self.tableView = [[UITableView alloc] init];
  [self.tableView setTranslatesAutoresizingMaskIntoConstraints:false];
  [rootView addSubview:self.tableView];
  [self addConstraintsToRootView:rootView withViews:@{@"tableView" : self.tableView}];
  
  self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
  self.searchController.searchResultsUpdater = self;
  self.searchController.dimsBackgroundDuringPresentation = NO;
  //self.searchController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"Search By Last name",@"Last name"),
  //  NSLocalizedString(@"Search By First name",@"First Name")];
  [self.searchController.searchBar sizeToFit];
  self.searchController.searchBar.delegate = self;
  self.searchController.searchBar.placeholder = @"Search by last name...";
  self.tableView.tableHeaderView = self.searchController.searchBar;
  
  self.view = rootView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"Reservations";
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  self.tableView.estimatedRowHeight = 4.0;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
  
  NSString *searchString = searchController.searchBar.text;
  NSLog(@"1");
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  HotelService *hotelService = appDelegate.hotelService;
  self.guests = [hotelService fetchGuestReservation: searchString];
  self.reservations = [hotelService fetchReservations];
  self.hotels = [hotelService fetchAllHotels];
  [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
  
  NSLog(@"2");
  [self updateSearchResultsForSearchController:self.searchController];
  NSString *searchString = _searchController.searchBar.text;
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  HotelService *hotelService = appDelegate.hotelService;
  self.guests = [hotelService fetchGuestReservationFirstName: searchString];
  [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.guests.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"forIndexPath:indexPath];
  Guest *guests = self.guests[indexPath.row];
  Reservation *resevations = self.reservations[indexPath.row];
  Hotel *hotels = self.hotels[indexPath.row];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateStyle = NSDateFormatterMediumStyle;
  NSString *formatStartDate = [dateFormatter stringFromDate: resevations.startDate];
  NSString *formatEndDate = [dateFormatter stringFromDate: resevations.endDate];
  cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
  cell.textLabel.numberOfLines = 0;
  cell.textLabel.text = [NSString stringWithFormat: @"Name: %@ %@ \nCheck in date: %@ \nCheck out date: %@ \nHotel: %@", guests.firstName, guests.lastName, formatStartDate, formatEndDate, hotels.name];
  return cell;
}

-(void)addConstraintsToRootView:(UIView *)rootView withViews:(NSDictionary *)views {
  
  NSArray *tableViewVertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewVertical];
  NSArray *tableViewHorizontal = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:views];
  [rootView addConstraints:tableViewHorizontal];
}
@end