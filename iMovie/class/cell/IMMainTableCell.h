//
//  IMMainTableCell.h
//  iMovie
//
//  Created by alan on 2014/9/13.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMProgressBar.h"

@interface IMMainTableCell : UITableViewCell

@property (nonatomic,strong)UIImageView *bg;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *engTitleLabel;
@property (nonatomic,strong)UIImageView *coverImageView;

@property (nonatomic,strong)IMProgressBar *progressBar;

@property (nonatomic,strong)UILabel *indexLabel;
@property (nonatomic,strong)UILabel *pttIndexLabel;
@property (nonatomic,strong)UIImageView *goodImageview;
@property (nonatomic,strong)UIImageView *badImageview;

@property (nonatomic,strong)UILabel *goodIndexLabel;
@property (nonatomic,strong)UILabel *badIndexLabel;

@property (nonatomic,strong)UILabel *badView;
@property (nonatomic,strong)UILabel *goodView;

@property (nonatomic,strong)UILabel *imdbLabel;
@property (nonatomic,strong)UILabel *yahooLabel;
@property (nonatomic,strong)UILabel *dateLabel;

-(void)setProgressWithGood:(NSInteger)good bad:(NSInteger)bad;


@end