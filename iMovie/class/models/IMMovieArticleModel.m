//
//  IMMovieArticleModel.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMovieArticleModel.h"

@implementation IMMovieArticleModel

-(NSString *)url
{
    return  [NSString stringWithFormat:@"https://www.ptt.cc/bbs/movie/%@.html",self._id];
}

+(NSArray *)parseListData:(id)data
{
    return [ACModelParser parse:data toClass:[IMMovieArticleModel class]];
}

-(void)printSelf
{
    NSLog(@"Id:%@ 標題:%@ 作者:%@ 推文數:%d",self._id,self.key_title,self.key_author,self.key_push);
}

@end
