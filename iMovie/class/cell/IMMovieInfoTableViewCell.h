//
//  IMMovieInfoTableViewCell.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMMovieInfoTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *messageLabel;

+(float)cellHeightWithDetail:(NSString *)text;

@end
