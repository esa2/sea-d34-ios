//
//  InterfaceController.m
//  RemindMe WatchKit Extension
//
//  Created by Ed Abrahamsen on 5/5/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "InterfaceController.h"
#import "CustomRowController.h"
#import <CoreLocation/CoreLocation.h>

@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *interfaceTable;

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context {
  [super awakeWithContext:context];
  
  NSArray *objectName = [[NSMutableArray alloc] initWithObjects: @"Starbucks", @"Bartells", @"Safron truck", @"The Wurst Place", @"Code Fellows", @"Gates Foundation", nil];
  
  [self.interfaceTable setNumberOfRows: objectName.count withRowType: @"Rows"];
  
  for (NSString *object in objectName) {
    long index = [objectName indexOfObject:object];
    CustomRowController *customRow = [self.interfaceTable rowControllerAtIndex :index];
    customRow.name.text = object;
  }
}
@end
