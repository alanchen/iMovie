//
//  IMPttTableViewCell.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMPttTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *pushLabel;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UILabel *idLabel;

+(float)cellHeightWithDetail:(NSString *)text;

-(void)setPush:(int)push;

@end
