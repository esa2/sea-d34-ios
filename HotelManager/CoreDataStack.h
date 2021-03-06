//
//  CoreDataStack.h
//  HotelManager
//
//  Created by Ed Abrahamsen on 5/6/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic) NSManagedObjectContext *backgroundContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (instancetype)initForTesting;
-(void)seedDataBaseIfNeeded;
@end
