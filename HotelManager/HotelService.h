//
//  HotelService.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CoreDataStack;
@class NSFetchedResultsController;
@class Reservation;
@class Room;
@interface HotelService : NSObject

-(instancetype)initWithCoreDataStack:(CoreDataStack *)coreDataStack;

-(NSArray *)fetchAllHotels;
-(NSArray *)fetchAHotel: (NSString *) hotelName;
-(NSArray *)fetchAllRoomsForHotel: (NSString *) hotelName;
-(NSArray *)fetchGuestReservation: (NSString *) lastName;
-(NSArray *)fetchGuestReservationFirstName: (NSString *) firstName;
-(NSArray *)fetchReservations;
-(Reservation *)makeReservation:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate withFirstName:(NSString *)firstName lastName:(NSString *)lastName;
-(NSFetchedResultsController *)fetchedResultsForAvailableRooms:(NSDate*)startDate toDate:(NSDate *)endDate;

@property (strong,nonatomic) CoreDataStack *coreDataStack;
@end