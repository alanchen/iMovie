//
//  AdBannerView.h
//  iMovie
//
//  Created by alan on 2014/8/24.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"

@interface AdBannerView : GADBannerView <GADBannerViewDelegate>

+(AdBannerView *)sharedInstance;
+(AdBannerView *)view;
-(void)loadAdRequest;
-(float)getDisplayHeight;


@property (nonatomic,readonly) float orinalViewHeight;
@property (nonatomic)BOOL isAdDidReceived;

@end
