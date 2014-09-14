//
//  IMErrorView.m
//  iMovie
//
//  Created by alan on 2014/9/14.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMErrorView.h"

@implementation IMErrorView


+(IMErrorView *)errorView
{
    IMErrorView *v = [[ IMErrorView alloc] initWithFrame:CGRectMake(0, 0, 280, 100)];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = [[UILabel alloc] initWithFrame:frame];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.height = 50;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.text = @"目前沒有電影資料，請稍後再試！";
        [self addSubview:self.textLabel];
        
        self.retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.retryButton.width = 100;
        self.retryButton.height = 50;
        [self.retryButton setTitle:@"再試一次" forState:UIControlStateNormal];
        [self.retryButton setTitleColor:ColorThemeGreen forState:UIControlStateNormal];
        [self.retryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];


        [self addSubview:self.retryButton];
        self.retryButton.centerX = self.width/2;
        self.retryButton.top = self.textLabel.bottom;
        
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];

}

@end
