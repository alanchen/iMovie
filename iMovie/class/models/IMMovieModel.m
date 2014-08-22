//
//  IMMovieModel.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMovieModel.h"
#import "NSDate+Format.h"

@implementation IMMovieModel

+(NSArray *)parseListData:(id)data
{
    return [ACModelParser parse:data toClass:[IMMovieModel class]];
}

-(void)printSelf
{
    NSLog(@"Id:%@ 片名:%@ 好雷:%d普雷:%d壞雷:%d",self._id,self.ch_name,self.gc,self.nc,self.bc);
}

-(NSString *)imdbText
{
    NSString *value =@"無資料";
    NSString *IMDB =@"IMDB:";
    
    if(self.imdb>0)
        value = [NSString stringWithFormat:@"%d",self.imdb];
    
    return [NSString stringWithFormat:@"%@ %@",IMDB,value];
}

-(NSString *)tomatoText
{
    NSString *value =@"無資料";
    NSString *TOMATO =@"爛番茄:";
    
    if(self.imdb>0)
        value = [NSString stringWithFormat:@"%d",self.tomato];
    
    return [NSString stringWithFormat:@"%@ %@",TOMATO,value];
}

-(NSString *)dateText
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.showtime*0.001];
    
    return [NSString stringWithFormat:@"上映日期: %@",[date prettyDate]];
}

@end
