//
//  NSArray+ACComon.m
//  ACCore
//
//  Created by alan on 13/10/9.
//  Copyright (c) 2013年 alan. All rights reserved.
//

#import "NSArray+ACComon.h"

@implementation NSArray(ACComon)

- (NSMutableArray *) getObjectsOfClass:(Class)theClass
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:theClass])
            [results addObject:obj];
    }];
        
    return results ;
}

- (NSArray *)reversedArray
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id obj in enumerator) {
        [array addObject:obj];
    }
    
    return array;
}

-(id)objectAtIndexSafely:(NSUInteger)index
{
    NSInteger count = [self count];
    
    if(count > index){
        return [self objectAtIndex:index];
    }
    
    return nil;
}

- (id)firstObject
{
    return [self objectAtIndexSafely:0];
}

@end
