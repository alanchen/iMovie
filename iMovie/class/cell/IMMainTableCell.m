//
//  IMMainTableCell.m
//  iMovie
//
//  Created by alan on 2014/9/13.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMainTableCell.h"

@implementation IMMainTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        self.backgroundColor = ColorThemeGray;
        self.contentView.backgroundColor =ColorThemeGray;
        
        self.bg = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.bg.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bg];
        
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.bg addSubview:self.coverImageView];
        
        self.titleLabel = [self addLabel];
        [self.titleLabel setFont:IMFont(20)];
        
        self.engTitleLabel = [self addLabel];
        self.engTitleLabel.textColor = ColorThemeTextGray;
        [self.engTitleLabel setFont:IMFont(12)];
        
        self.indexLabel = [self addLabel];
        self.indexLabel.size = CGSizeMake(30, 15);
        self.indexLabel.textColor = ColorThemePink;
        [self.indexLabel setFont:IMFont(18)];
        self.indexLabel.textAlignment = NSTextAlignmentRight;
        
        self.pttIndexLabel = [self addLabel];
        [self.pttIndexLabel setFont:IMFont(12)];
        self.pttIndexLabel.textAlignment = NSTextAlignmentCenter;
        
        self.goodImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"good_index"]];
        [self.bg addSubview:self.goodImageview];
        
        self.badImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bad_index"]];
        [self.bg addSubview:self.badImageview];
        
        self.goodIndexLabel = [self addLabel];
        self.goodIndexLabel.size = CGSizeMake(50, 15);
        [self.bg addSubview:self.goodIndexLabel];
        
        self.badIndexLabel = [self addLabel];
        self.badIndexLabel.size = CGSizeMake(50, 15);
        self.badIndexLabel.textAlignment = NSTextAlignmentRight;
        [self.bg addSubview:self.badIndexLabel];
        
        self.progressBar = [IMProgressBar progressBar];
        [self.bg addSubview:self.progressBar];
        
        self.imdbLabel = [self addLabel];
        self.imdbLabel.textColor = ColorThemeTextGray;
        [self.imdbLabel setFont:IMFont(12)];
        
        self.yahooLabel = [self addLabel];
        self.yahooLabel.textColor = ColorThemeTextGray;
        [self.yahooLabel setFont:IMFont(12)];
        
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
    l.textColor = [UIColor blackColor];
    [self.bg addSubview:l];
    
    return l;
}

-(void)setProgressWithGood:(NSInteger)good bad:(NSInteger)bad
{
    NSInteger total = good+bad;
    
    float progress = (float)good / (float)total;
    
    self.progressBar.progress = progress;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if(highlighted)
    {
        self.bg.backgroundColor = ColorThemeGreen;
    }
    else
    {
        self.bg.backgroundColor = [UIColor whiteColor];
    }
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
    self.titleLabel.top = 3;
    
    self.engTitleLabel.size = CGSizeMake(bgWidth - 2*padding, 15);
    self.engTitleLabel.centerX = bgWidth/2;
    self.engTitleLabel.top = self.titleLabel.bottom;

    self.coverImageView.size = CGSizeMake(104, 150);
    self.coverImageView.left = self.engTitleLabel.left;
    self.coverImageView.top = self.engTitleLabel.bottom+3;
    
    self.indexLabel.right = bgWidth -padding;
    self.indexLabel.top = padding;

    
    self.pttIndexLabel.size = CGSizeMake(bgWidth - self.coverImageView.right - 2*padding, 30);
    self.pttIndexLabel.left = self.coverImageView.right + padding;
    self.pttIndexLabel.top = self.coverImageView.top;

    self.goodImageview.left = self.pttIndexLabel.left+padding;
    self.goodImageview.top = self.pttIndexLabel.bottom+padding;
    
    self.badImageview.right = self.pttIndexLabel.right-padding;
    self.badImageview.top = self.pttIndexLabel.bottom+padding;
    
    self.goodIndexLabel.left = self.goodImageview.left;
    self.goodIndexLabel.top = self.goodImageview.bottom+ padding;
    
    self.badIndexLabel.right = self.badImageview.right;
    self.badIndexLabel.top = self.badImageview.bottom+ padding;
    
    self.progressBar.height = 30;
    self.progressBar.width = self.goodImageview.centerX -  self.badImageview.centerX;
    self.progressBar.left = self.goodImageview.centerX;
    self.progressBar.centerY = self.goodIndexLabel.centerY;

    self.dateLabel.size = CGSizeMake(150, 15);
    self.dateLabel.right = bgWidth-padding;
    self.dateLabel.bottom = self.coverImageView.bottom;
    
    self.yahooLabel.size = CGSizeMake(100, 15);
    self.yahooLabel.left = self.coverImageView.right + padding;
    self.yahooLabel.bottom = self.dateLabel.bottom;
    
    self.imdbLabel.size = CGSizeMake(100, 15);
    self.imdbLabel.left = self.yahooLabel.left;
    self.imdbLabel.bottom = self.yahooLabel.top;
//
//    self.commentLabel.width = self.descriptionLabel.width;
//    self.commentLabel.height = self.descriptionLabel.bottom - self.imdbLabel.top;
//    self.commentLabel.left = self.descriptionLabel.left;
//    self.commentLabel.top = self.descriptionLabel.bottom;
}



@end
