//
//  IMErrorView.h
//  iMovie
//
//  Created by alan on 2014/9/14.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMErrorView : UIView

@property (nonatomic,strong)UILabel *textLabel;
@property (nonatomic,strong)UIButton *retryButton;

+(IMErrorView *)errorView;

@end
