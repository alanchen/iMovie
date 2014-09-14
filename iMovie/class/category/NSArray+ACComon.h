//
//  NSArray+ACComon.h
//  ACCore
//
//  Created by alan on 13/10/9.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(ACComon)

- (NSMutableArray *) getObjectsOfClass:(Class)theClass;
- (NSArray *)  reversedArray;

-(id)objectAtIndexSafely:(NSUInteger)index;
- (id)firstObject;

@end
