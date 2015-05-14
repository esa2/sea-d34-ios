//
//  HotelService.m
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "HotelService.h"
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"
#import "Hotel.h"

@interface HotelService ()
@end

@implementation HotelService

-(instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack {
  self = [super init];
  if (self) {
    self.coreDataStack = coreDataStack;
  }
  return self;
}

-(NSArray *)fetchAllHotels {
  
  NSFetchRequest *hotelFetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:hotelFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
    return nil;
  }
  return results;
}

-(NSArray *)fetchAHotel: (NSString *)hotelName {
  
  NSFetchRequest *hotelFetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", hotelName];
  hotelFetch.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:hotelFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
    return nil;
  }
  return results;
}

-(NSArray *)fetchAllRoomsForHotel: (NSString *)hotelName {
  
  NSFetchRequest *roomFetch = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hotel.name == %@", hotelName];
  roomFetch.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:roomFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
    return nil;
  }
  return results;
}

-(NSArray *)fetchGuestReservation: (NSString *)lastName {
  
  NSFetchRequest *guestFetch = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lastName == %@", lastName];
  guestFetch.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:guestFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
    return nil;
  }
  return results;
}

-(NSArray *)fetchReservations {
  
  NSFetchRequest *reservationFetch = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:reservationFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
    return nil;
  }
  return results;
}


-(NSArray *)fetchGuestReservationFirstName: (NSString *)firstName {
  
  NSFetchRequest *guestFetch = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstName == %@", firstName];
  guestFetch.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:guestFetch error:&fetchError];
  if (fetchError) {
    NSLog(@"%@",fetchError.localizedDescription);
    return nil;
  }
  return results;
}


-(NSFetchedResultsController *)fetchedResultsForAvailableRooms:(NSDate*)startDate toDate:(NSDate *)endDate {
  
  NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@",endDate,startDate];
  request.predicate = predicate;
  NSError *fetchError;
  NSArray *results = [self.coreDataStack.managedObjectContext executeFetchRequest:request error:&fetchError];
  
  NSMutableArray *badRooms = [[NSMutableArray alloc] init];
  for (Reservation *reservation in results) {
    [badRooms addObject:reservation.room];
  }
  
  NSFetchRequest *roomRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
  NSPredicate *roomPredicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", badRooms];
  NSSortDescriptor *hotelNameSort = [NSSortDescriptor sortDescriptorWithKey:@"hotel.name" ascending:true];
  NSSortDescriptor *roomSort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:true];
  
  roomRequest.sortDescriptors = @[hotelNameSort, roomSort];
  roomRequest.predicate = roomPredicate;
  NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:roomRequest managedObjectContext:self.coreDataStack.managedObjectContext sectionNameKeyPath:@"hotel.name" cacheName:@"Available rooms cache"];
  return fetchedResultsController;
  
}

-(Reservation *)makeReservation:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withFirstName:(NSString *)firstName lastName:(NSString *)lastName {
  
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  reservation.room = room;
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.coreDataStack.managedObjectContext];
  guest.firstName = firstName;
  guest.lastName = lastName;
  reservation.guest = guest;
  
  NSError *saveError;
  [self.coreDataStack.managedObjectContext save:&saveError];
  
  if (saveError) {
    NSLog(@"Error saving: %@", saveError);
    return nil;
  }
  return reservation;
}

-(void)fetchOnBackground {
  NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
  NSArray *results = [self.coreDataStack.backgroundContext executeFetchRequest:fetch error:nil];
  NSMutableArray *objectIDs = [[NSMutableArray alloc] init];
  for (Hotel *hotel in results) {
    [objectIDs addObject:hotel.objectID];
  }
  
  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    NSMutableArray *hotels = [NSMutableArray new];
    for (NSManagedObjectID *objectID in objectIDs) {
      Hotel *hotel = (Hotel *)[self.coreDataStack.managedObjectContext objectWithID:objectID];
      [hotels addObject:hotel];
    }
  }];
}
@end