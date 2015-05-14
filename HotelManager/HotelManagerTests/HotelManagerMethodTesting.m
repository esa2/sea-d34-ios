
  HotelManagerMethodTesting.m
  HotelManager

  Created by Ed Abrahamsen on 5/13/15.
  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.


#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoreDataStack.h"
#import "HotelService.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"

@interface HotelManagerMethodTesting : XCTestCase

@property (strong, nonatomic) CoreDataStack *coreDataStack;
@property (strong, nonatomic) HotelService *hotelService;
@end

@implementation HotelManagerMethodTesting

- (void)setUp {
  [super setUp];
  self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  self.hotelService = [[HotelService alloc] initWithCoreDataStack:self.coreDataStack];
}

- (void)tearDown {
  self.coreDataStack = nil;
  self.hotelService = nil;
  [super tearDown];
}


-(Hotel *)addHotels {
  Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  hotel.name = "@Fawlty Towers";
  hotel.location = @"Liverpool";
  return hotel;
}

-(Guest *)addGuest {
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  guest.firstName = @"Ed";
  guest.lastName = @"Abrahamsen";
  return guest;
}

-(void)testFetchAllHotelsNil {
  NSArray *hotel = [self.hotelService fetchAllHotels];
  XCTAssert(hotel.count == 0, @"Error when hotels are nil");
}

-(void)testFetchAllHotelsMultiple {
  NSArray *hotel = [self.HotelService fetchAllHotels]
  XTCAsset(hotel.count == 2, @"Error fetching multiple hotels");
}

-(void)testFetchAHotelNil {
  NSArray *hotel = [self.hotelService fetchAHotel];
  XCTAssert(hotel.count == 0, @"Error when hotels are nil");
}

-(void)testFetchAHotelByName {
  NSArray *hotel = [self.hotelService fetchAHotel];
  XCTAssertTrue(hotel.name == @"Fawlty Towers" , @"Error when hotel not found");
}

@end
