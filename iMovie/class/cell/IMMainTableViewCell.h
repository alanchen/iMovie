//
//  IMMainTableViewCell.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMMainTableViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *bg;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UIImageView *coverImageView;
@property (nonatomic,strong)UILabel *descriptionLabel;

@property (nonatomic,strong)UILabel *imdbLabel;
@property (nonatomic,strong)UILabel *tomatoLabel;
@property (nonatomic,strong)UILabel *dateLabel;


@end
