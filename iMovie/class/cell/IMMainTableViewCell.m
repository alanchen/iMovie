//
//  IMMainTableViewCell.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMainTableViewCell.h"

@implementation IMMainTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];

        self.bg = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.bg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.bg];
        
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.bg addSubview:self.coverImageView];
        
        self.titleLabel = [self addLabel];
        [self.titleLabel setFont:IMFont(20)];
        
        self.descriptionLabel = [self addLabel];
        [self.descriptionLabel setFont:IMFont(11)];
        self.descriptionLabel.numberOfLines = 0;

        self.imdbLabel = [self addLabel];
        [self.imdbLabel setFont:IMFont(12)];

        self.tomatoLabel = [self addLabel];
        [self.tomatoLabel setFont:IMFont(12)];

        self.dateLabel = [self addLabel];
        self.dateLabel.textAlignment =  NSTextAlignmentRight;
        [self.dateLabel setFont:IMFont(12)];
    }
    
    return self;
}

-(UILabel *)addLabel
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
    l.backgroundColor = [UIColor clearColor];
    [self.bg addSubview:l];
    
    return l;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    float bgPadding = 5.0;
    float padding = 10.0;

    float viewWidth = self.contentView.width;
    float bgWidth = viewWidth - bgPadding*2;
    float bgHeight = self.contentView.height - bgPadding*2;

    
    self.bg.width = bgWidth;
    self.bg.height = bgHeight;
    self.bg.top = bgPadding;
    self.bg.left = bgPadding;
    
    self.titleLabel.size = CGSizeMake(bgWidth - 2*padding, 25);
    self.titleLabel.centerX = bgWidth/2;
    self.titleLabel.top = padding;
    
    self.coverImageView.size = CGSizeMake(104, 150);
    self.coverImageView.left = self.titleLabel.left;
    self.coverImageView.top = self.titleLabel.bottom+7;
    
    self.descriptionLabel.size = CGSizeMake(bgWidth - self.coverImageView.right - 2*padding, 60);
    self.descriptionLabel.left = self.coverImageView.right+padding;
    self.descriptionLabel.top = self.coverImageView.top;
    
    self.dateLabel.size = CGSizeMake(150, 15);
    self.dateLabel.right = bgWidth-padding;
    self.dateLabel.bottom = self.coverImageView.bottom;
    
    self.tomatoLabel.size = CGSizeMake(100, 15);
    self.tomatoLabel.left = self.descriptionLabel.left;
    self.tomatoLabel.bottom = self.dateLabel.top;
    
    self.imdbLabel.size = CGSizeMake(100, 15);
    self.imdbLabel.left = self.descriptionLabel.left;
    self.imdbLabel.bottom = self.tomatoLabel.top;

}

@end
