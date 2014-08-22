//
//  IMMovieDetailModel.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMovieDetailModel.h"

@implementation IMMovieDetailModel

+(IMMovieDetailModel *)parseModelData:(id)data
{
    return [ACModelParser parse:data toClass:[IMMovieDetailModel class]];
}

-(void)printSelf
{
    NSLog(@"Id:%@ 導演:%@ 片長:%@ 演員:%@ %@",self._id,self.key_director,self.key_length,self.key_actors,self.key_full_desc);
}

@end
