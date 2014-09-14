//
//  IMMovieModel.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACModelParser.h"


@interface IMMovieModel : NSObject

@property (nonatomic,strong)NSString *_id;
@property (nonatomic,strong)NSString *ch_name;
@property (nonatomic,strong)NSString *ori_name;
@property (nonatomic,strong)NSString *thumbnail_small;
@property (nonatomic,strong)NSString *thumbnail_big;
@property (nonatomic,strong)NSString *description;

@property (nonatomic)NSTimeInterval showtime;

@property (nonatomic)int gc;
@property (nonatomic)int bc;
@property (nonatomic)int nc;
@property (nonatomic)int total;

@property (nonatomic)int imdb;
@property (nonatomic)int tomato;
@property (nonatomic)int tp_rank;

+(NSArray *)parseListData:(id)data;

-(void)printSelf;

-(NSString *)tomatoText;
-(NSString *)imdbText;
-(NSString *)dateText;

-(NSMutableAttributedString *)commentAttributedText;
-(NSMutableAttributedString *)pttIndexText;


@end
