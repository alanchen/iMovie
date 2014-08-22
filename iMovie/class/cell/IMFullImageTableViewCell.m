//
//  IMFullImageTableViewCell.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMFullImageTableViewCell.h"

@implementation IMFullImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.fullImageView= [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.fullImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.fullImageView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.fullImageView.size = self.contentView.size;
}

@end
