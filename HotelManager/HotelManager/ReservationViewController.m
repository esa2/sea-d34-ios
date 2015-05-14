//
//  ReservationViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "AppDelegate.h"
#import "ReservationViewController.h"
#import "Guest.h"
#import "Reservation.h"
#import "Hotel.h"

@interface ReservationViewController ()

@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UIButton *reservationButton;
@property (strong, nonatomic) UIButton *homeButton;
@property (strong, nonatomic) UILabel *reservationInfoLabel;
@property (strong, nonatomic) UILabel *hotelNameLabel;
@property (strong, nonatomic) UILabel *roomNumberLabel;
@property (strong, nonatomic) UILabel *roomServiceLabel;
@property (strong, nonatomic) UILabel *poolLabel;
@property (strong, nonatomic) UILabel *startDateLabel;
@property (strong, nonatomic) UILabel *endDateLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *confirmationLabel;
@end

@implementation ReservationViewController

-(void)loadView {
  self.view = [[UIView alloc] init];
  self.view.backgroundColor = [UIColor whiteColor];
  self.firstNameField = [[UITextField alloc] init];
  self.lastNameField = [[UITextField alloc] init];
  self.reservationButton = [[UIButton alloc] init];
  self.homeButton = [[UIButton alloc] init];
  self.hotelNameLabel = [[UILabel alloc] init];
  self.roomNumberLabel = [[UILabel alloc] init];
  self.roomServiceLabel = [[UILabel alloc] init];
  self.poolLabel = [[UILabel alloc] init];
  self.startDateLabel = [[UILabel alloc] init];
  self.endDateLabel = [[UILabel alloc] init];
  self.priceLabel = [[UILabel alloc] init];
  self.confirmationLabel = [[UILabel alloc] init];
  [self constrainSubviews];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self initializeFields];
  self.navigationItem.title = @"Make a reservation";
}

- (void)initializeFields {
  self.firstNameField.placeholder = @"Enter first name...";
  self.lastNameField.placeholder = @"Enter last name...";
  self.firstNameField.backgroundColor = [UIColor lightGrayColor];
  self.lastNameField.backgroundColor = [UIColor lightGrayColor];
  self.reservationButton.backgroundColor = [UIColor blueColor];
  [self.reservationButton setTitle:@" Make reservation " forState:UIControlStateNormal];
  [self.reservationButton addTarget:self action:@selector(makeReservationPressed) forControlEvents:UIControlEventTouchUpInside];
  self.homeButton.backgroundColor = [UIColor whiteColor];
  [self.homeButton setTitle:@" Home " forState:UIControlStateNormal];
  [self.homeButton addTarget:self action:@selector(homePressed) forControlEvents:UIControlEventTouchUpInside];

  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateStyle = NSDateFormatterMediumStyle;
  NSString *formatStartDate = [dateFormatter stringFromDate:self.startDate];
  NSString *formatEndDate = [dateFormatter stringFromDate:self.endDate];
  
  self.hotelNameLabel.text = [NSString stringWithFormat: @" Hotel:                %@", self.room.hotel.name];
  self.roomNumberLabel.text = [NSString stringWithFormat: @" Room#:              %@", self.room.number];
  self.roomServiceLabel.text = [NSString stringWithFormat: @" Room Service:    %@", self.room.hotel.roomService];
  self.poolLabel.text = [NSString stringWithFormat: @" Pool:                  %@", self.room.hotel.swimmingPool];
  self.startDateLabel.text = [NSString stringWithFormat: @" Check in:            4 PM %@", formatStartDate];
  self.endDateLabel.text = [NSString stringWithFormat: @" Check out:          11 AM %@", formatEndDate];
  self.priceLabel.text = [NSString stringWithFormat: @" Price:                   $%@", self.room.rate];
}

- (void)makeReservationPressed {
  
  if([self.firstNameField.text isEqualToString:@""]) {
    self.firstNameField.placeholder = @"You must enter a first name";
  }
  else if ([self.lastNameField.text isEqualToString:@""]) {
     self.lastNameField.placeholder = @"You must enter a last name";
  }
  else {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.hotelService makeReservation:self.room startDate:self.startDate endDate:self.endDate withFirstName:self.firstNameField.text lastName:self.lastNameField.text];
    
    [self.reservationButton setTitle:@" Reservation confirmed " forState:UIControlStateNormal];
    self.reservationButton.backgroundColor = [UIColor whiteColor];
    [self.reservationButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    self.homeButton.backgroundColor = [UIColor blueColor];
    [self.homeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  }
}

- (void)homePressed {
  
  [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)constrainSubviews   {
  
 NSDictionary *views = @{ @"hotelName": self.hotelNameLabel, @"roomNumber": self.roomNumberLabel, @"roomService": self.roomServiceLabel, @"pool": self.poolLabel, @"startDate": self.startDateLabel, @"endDate": self.endDateLabel, @"price": self.priceLabel, @"firstName" : self.firstNameField, @"lastName" : self.lastNameField, @"reservation" : self.reservationButton, @"home" : self.homeButton};
  
  for (NSString* key in views) {
    UIView *subView = [views objectForKey:key];
    [self.view addSubview:subView];
    [subView setTranslatesAutoresizingMaskIntoConstraints:false];
    NSMutableArray * constraints = [NSMutableArray array];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:subView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
    
    [self.view addConstraints:constraints];
  }
  
  NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-80-[hotelName]-20-[roomNumber]-20-[roomService]-20-[pool]-20-[startDate]-20-[endDate]-20-[price]-20-[firstName]-20-[lastName]-20-[reservation]-40-[home]-120-|" options:0 metrics:nil views:views];
  [self.view addConstraints:verticalConstraints];
  
  //  NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[reservation]|" options:0 metrics:nil views:views];
  //  [self.view addConstraints:horizontalConstraints];
  
  //  self.view.layoutMargins = UIEdgeInsetsMake(0,42,0,42); // set left and right margins to 42
  //  NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[separatorView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(subView)];
  //  [self.view addConstraints:constraints];
  //  
  
}
@end