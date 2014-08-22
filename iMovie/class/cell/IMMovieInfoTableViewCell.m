//
//  IMMovieInfoTableViewCell.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMovieInfoTableViewCell.h"


#define kArticleTitleHeight 20
#define KPadding  10
#define kArticleDetailFont  IMFont(16)
#define kArticleDetailLineBreak NSLineBreakByTruncatingTail
#define KContentWidth ([UIScreen mainScreen].bounds.size.width - 2*KPadding)

@implementation IMMovieInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = IMFont(18);
        [self.contentView addSubview:self.titleLabel];
        
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.messageLabel.backgroundColor = [UIColor clearColor];
        self.messageLabel.lineBreakMode = kArticleDetailLineBreak;
        self.messageLabel.font =kArticleDetailFont;
        self.messageLabel.numberOfLines = 0;
        [self.contentView addSubview:self.messageLabel];
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
    
    self.titleLabel.size = CGSizeMake(KContentWidth , kArticleTitleHeight);
    self.titleLabel.top = KPadding;
    self.titleLabel.left = KPadding;
    
    self.messageLabel.width = KContentWidth;
    self.messageLabel.height = self.contentView.height - kArticleTitleHeight - 2*KPadding + 5;
    self.messageLabel.top = self.titleLabel.bottom;
    self.messageLabel.left = KPadding;

}

+(float)heightWithDetail:(NSString *)text
{
    CGSize size = [text sizeWithFont:kArticleDetailFont
                   constrainedToSize:CGSizeMake(KContentWidth, 9999)
                       lineBreakMode:kArticleDetailLineBreak];
    return  size.height;
}

+(float)cellHeightWithDetail:(NSString *)text
{
    return KPadding + kArticleTitleHeight + [IMMovieInfoTableViewCell heightWithDetail:text] + KPadding;
}

@end
