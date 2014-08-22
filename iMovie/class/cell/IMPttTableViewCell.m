//
//  IMPttTableViewCell.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMPttTableViewCell.h"

#define kIdHeight 25
#define KPadding  10
#define kPushLableWH 30
#define kTitleFont  IMFont(18)
#define kTitleLineBreak NSLineBreakByTruncatingTail
#define KContentWidth ([UIScreen mainScreen].bounds.size.width - 2*KPadding - kPushLableWH)

@implementation IMPttTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.pushLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.pushLabel.backgroundColor = [UIColor clearColor];
        self.pushLabel.font =kTitleFont;
        self.pushLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.pushLabel];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.lineBreakMode = kTitleLineBreak;
        self.titleLabel.font =kTitleFont;
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        self.idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.idLabel.backgroundColor = [UIColor clearColor];
        self.idLabel.font =IMFont(14);
        [self.contentView addSubview:self.idLabel];
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
    
    self.pushLabel.size = CGSizeMake(kPushLableWH ,kPushLableWH);
    self.pushLabel.top = KPadding;
    self.pushLabel.left = KPadding;
    
    self.titleLabel.size = CGSizeMake(KContentWidth , self.contentView.height - kIdHeight + 5);
    self.titleLabel.left = self.pushLabel.right;
    
    self.idLabel.width = KContentWidth;
    self.idLabel.height = kIdHeight;
    self.idLabel.bottom = self.contentView.height;
    self.idLabel.left = self.pushLabel.right;
    
}

+(float)heightWithDetail:(NSString *)text
{
    CGSize size = [text sizeWithFont:kTitleFont
                   constrainedToSize:CGSizeMake(KContentWidth, 9999)
                       lineBreakMode:kTitleLineBreak];
    return  size.height;
}

+(float)cellHeightWithDetail:(NSString *)text
{
    return [IMPttTableViewCell heightWithDetail:text] + kIdHeight + 5;
}

-(void)setPush:(int)push
{
    self.pushLabel.text = [NSString stringWithFormat:@"%d",push];
    
    if(push<=0){
        self.pushLabel.hidden = YES;
    }
    else{
        if(push<=10)
            self.pushLabel.textColor = [UIColor greenColor];
        else if(push>10)
            self.pushLabel.textColor = [UIColor yellowColor];
    }
    
}


@end
