//
//  NSDate+Format.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "NSDate+Format.h"

@implementation NSDate(Format)

- (NSString *)prettyDate
{
    NSString * prettyTimestamp;
    NSInteger dayTime = 60*60*24;
    NSInteger weekTime = dayTime * 7;
    NSInteger oneDay = dayTime * 1;
    NSInteger twoDay = dayTime * 2;
    NSInteger threeDay = dayTime * 3;
    
    NSTimeInterval delta = [[NSDate date] timeIntervalSince1970] - [self timeIntervalSince1970];

    if (delta < 0) { // future
        prettyTimestamp = [self displayDateFormat:@"yyyy/MM/dd"];
    }else if (delta < oneDay) {
        prettyTimestamp = @"今天";
    }else if (delta < twoDay) {
        prettyTimestamp = @"昨天";
    }else if (delta < threeDay) {
        prettyTimestamp = @"前天";
    }else if (delta < weekTime) {
        prettyTimestamp = @"三天前";
    }else if (delta < 2*weekTime) {
        prettyTimestamp =  @"一周前";
    }else if (delta  < 3*weekTime) {
        prettyTimestamp = @"二周前";
    }else if (delta  < 4*weekTime) {
        prettyTimestamp = @"三周前";
    }else if (delta  < 5*weekTime) {
        prettyTimestamp = @"一個月前";
    }else{
       prettyTimestamp = [self displayDateFormat:@"yyyy/MM/dd"];}

    return prettyTimestamp;
}

- (NSString *)displayDateFormat:(NSString *)Format
{
    NSDateFormatter *output = [[NSDateFormatter alloc] init];
    [output setDateFormat:Format];
    
    return [output stringFromDate:self];
}


@end
