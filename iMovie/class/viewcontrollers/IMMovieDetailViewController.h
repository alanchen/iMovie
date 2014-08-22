//
//  IMMovieDetailViewController.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMMovieModel.h"
#import "IMMovieDetailModel.h"

@interface IMMovieDetailViewController : UIViewController

@property (nonatomic,strong)IMMovieModel *movie;
@property (nonatomic,strong)IMMovieDetailModel *movieDetail;

- (id)initWithMovie:(IMMovieModel *)movie;


@end
