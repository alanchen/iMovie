//
//  IMMovieArticleModel.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACModelParser.h"

@interface IMMovieArticleModel : NSObject

@property (nonatomic,strong)NSString *_id;
@property (nonatomic,strong)NSString *key_title;
@property (nonatomic,strong)NSString *key_author;

@property (nonatomic)NSInteger key_push;
@property (nonatomic)NSTimeInterval key_ts;
@property (nonatomic)BOOL key_ismarked;

+(NSArray *)parseListData:(id)data;

-(void)printSelf;

@end
