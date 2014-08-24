//
//  AdBannerView.m
//  iMovie
//
//  Created by alan on 2014/8/24.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "AdBannerView.h"

#define kAdUnitID @"ca-app-pub-7751839166118431/1600710305"

@implementation AdBannerView

+(AdBannerView *)sharedInstance
{
    static AdBannerView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AdBannerView view];
        [NSTimer scheduledTimerWithTimeInterval:30 target:sharedInstance selector:@selector(checkFailAndReload) userInfo:nil repeats:YES];

    });
    
    return sharedInstance;
}


+(AdBannerView *)view
{
    AdBannerView *adBannerView = [[AdBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    
    adBannerView.delegate = adBannerView;
    adBannerView.adUnitID = kAdUnitID;
    
    return adBannerView;
}

-(void)loadAdRequest
{
    [self loadRequest:[GADRequest request]];
}

-(float)getDisplayHeight
{
    if(_isAdDidReceived)
        return self.height;
    
    return 0;
}

-(void)layoutNavigatioController
{
    UINavigationController *navi = (UINavigationController *)self.window.rootViewController;

    if(_orinalViewHeight==0){
        _orinalViewHeight =navi.view.height;
    }
    
    navi.view.height = _orinalViewHeight - self.height;
    
    [navi.view setNeedsLayout];
    [navi.view layoutIfNeeded];
}

-(void)checkFailAndReload
{
    if(self.isAdDidReceived == NO)
        [self loadAdRequest];
}


#pragma  mark - delegate

/// Called when an ad request loaded an ad. This is a good opportunity to add this view to the
/// hierarchy if it has not been added yet. If the ad was received as a part of the server-side auto
/// refreshing, you can examine the hasAutoRefreshed property of the view.
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    self.isAdDidReceived = YES;
    self.bottom = [self.window bounds].size.height;
    
    [self layoutNavigatioController];
}

/// Called when an ad request failed. Normally this is because no network connection was available
/// or no ads were available (i.e. no fill). If the error was received as a part of the server-side
/// auto refreshing, you can examine the hasAutoRefreshed property of the view.
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    self.isAdDidReceived = NO;
    self.top = [self.window bounds].size.height;

    [self layoutNavigatioController];
}

#pragma mark Click-Time Lifecycle Notifications

/// Called just before presenting the user a full screen view, such as a browser, in response to
/// clicking on an ad. Use this opportunity to stop animations, time sensitive interactions, etc.
///
/// Normally the user looks at the ad, dismisses it, and control returns to your application by
/// calling adViewDidDismissScreen:. However if the user hits the Home button or clicks on an App
/// Store link your application will end. On iOS 4.0+ the next method called will be
/// applicationWillResignActive: of your UIViewController
/// (UIApplicationWillResignActiveNotification). Immediately after that adViewWillLeaveApplication:
/// is called.
- (void)adViewWillPresentScreen:(GADBannerView *)adView
{
    
}

/// Called just before dismissing a full screen view.
- (void)adViewWillDismissScreen:(GADBannerView *)adView;
{
    
}

/// Called just after dismissing a full screen view. Use this opportunity to restart anything you
/// may have stopped as part of adViewWillPresentScreen:.
- (void)adViewDidDismissScreen:(GADBannerView *)adView
{
    
}

/// Called just before the application will background or terminate because the user clicked on an
/// ad that will launch another application (such as the App Store). The normal
/// UIApplicationDelegate methods, like applicationDidEnterBackground:, will be called immediately
/// before this.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView
{
    
    
}

@end

