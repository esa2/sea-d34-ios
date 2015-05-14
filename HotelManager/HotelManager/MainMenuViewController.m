//
//  MainMenuViewController.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/7/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import "MainMenuViewController.h"
#import "HotelViewController.h"
#import "FromDateViewController.h"
#import "ReservationLookupViewController.h"

@interface MainMenuViewController ()

@property (strong,nonatomic) NSArray *options;
@end

@implementation MainMenuViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.options = @[@"View all hotels",@"Reserve a room", @"View your reservations"];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"OptionCell"];
 // self.navigationItem.leftBarButtonItem = self.editButtonItem;
  self.title = @"Home";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell" forIndexPath:indexPath];
  NSString *option = self.options[indexPath.row];
  cell.textLabel.text = option;
  return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  switch (indexPath.row) {
    case 0: {
      HotelViewController *hotelListVC = [[HotelViewController alloc] init];
      [self.navigationController pushViewController:hotelListVC animated:true];
    }
      break;
    case 1: {
      FromDateViewController *fromDateVC = [[FromDateViewController alloc] init];
      [self.navigationController pushViewController:fromDateVC animated:true];
    }
      break;
    case 2: {
      ReservationLookupViewController *lookupVC = [[ReservationLookupViewController alloc] init];
      [self.navigationController pushViewController:lookupVC animated:true];
    }
    default:
      break;
  }
}
@end