//
//  IMMovieModel.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMovieModel.h"

@implementation IMMovieModel

+(NSArray *)parseListData:(id)data
{
    return [ACModelParser parse:data toClass:[IMMovieModel class]];
}

-(void)printSelf
{
    NSLog(@"Id:%@ 片名:%@ 好雷:%d普雷:%d壞雷:%d",self._id,self.ch_name,self.gc,self.nc,self.bc);
}

@end
