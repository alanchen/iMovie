//
//  IMMovieDetailModel.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACModelParser.h"

@interface IMMovieDetailModel : NSObject

@property (nonatomic,strong)NSString *_id;
@property (nonatomic,strong)NSString *key_director;
@property (nonatomic,strong)NSString *key_length;
@property (nonatomic,strong)NSString *key_actors;
@property (nonatomic,strong)NSString *key_full_desc;
@property (nonatomic,strong)NSArray *key_photos;

+(IMMovieDetailModel *)parseModelData:(id)data;

-(void)printSelf;

@end
