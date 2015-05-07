//
//  StackAndQueue.m
//  RemindMe
//
//  Created by Ed Abrahamsen on 5/2/15.
//  Copyright (c) 2015 Ed Abrahamsen. All rights reserved.
//
#import "StackAndQueue.h"
#import <Foundation/Foundation.h>

@interface StackAndQueue:

NSMutableArray {
  NSMutableArray *stackOrQueueArray;
  long count;
}

@end

@implementation StackAndQueue

-(id)init {
  if (self = [super init]) {
    count = 0;
    stackOrQueueArray = [[NSMutableArray alloc]init];
  }
  return self;
}

-(long) push: (id)object {
  [stackOrQueueArray addObject: object];
  count = stackOrQueueArray.count;
  return count;
}

- (id) pop {
  id object = nil;
  if ([stackOrQueueArray count] > 0) {
    count--;
    object = [stackOrQueueArray objectAtIndex: (count)];
    [stackOrQueueArray removeObjectAtIndex: (count)];
  }
  return object;
}

-(id) peek {
  id object = nil;
  if ([stackOrQueueArray count] > 0) {
    object = [stackOrQueueArray objectAtIndex: (count - 1)];
  }
  return object;
}

- (void)enqueue:(id)anObject
{
  [stackOrQueueArray addObject: anObject];
  count = stackOrQueueArray.count;
}

-(id)dequeue
{
  id object = nil;
  if(stackOrQueueArray.count > 0)
  {
    object = [stackOrQueueArray objectAtIndex: 0];
    [stackOrQueueArray removeObjectAtIndex: 0];
    count = stackOrQueueArray.count;
  }
  return object;
}

@end





