//
//  IMAppDelegate.m
//  iMovie
//
//  Created by alan on 2014/8/21.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMAppDelegate.h"
#import "IMMainViewController.h"
#import "UIViewController+Style.h"
#import "IMNaviSpinner.h"
#import "GAI.h"
#import <Crashlytics/Crashlytics.h>

#define kGoogleAnalyticsId  @"UA-46013282-5"

@implementation IMAppDelegate

#pragma  mark - Override

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initWindow];
    [self initAdBanner];
    [self initGA];
    [self initCrashlytics];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma  mark - Init

-(void)initWindow
{
    // Tirck for ios6 admob bug
    if(IS_OS_7_OR_LATER == NO)
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    IMMainViewController *rootVC = [[IMMainViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rootVC];
    
    [rootVC setNavigationBarBackgroundColor:ColorThemeBlue];
    [rootVC setTitleImage:@"title"];
    [UIViewController setNavigationTitleColor:[UIColor whiteColor]];
    
    IMNaviSpinner *spinner = [IMNaviSpinner sharedInstance];
    [navi.navigationBar addSubview:spinner];
    spinner.centerY = navi.navigationBar.height/2;
    spinner.right = navi.navigationBar.width - 10;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
}

-(void)initAdBanner
{
    _adBannerView = [AdBannerView sharedInstance];
    _adBannerView.rootViewController = self.window.rootViewController;
    [_adBannerView loadAdRequest];
    
    [self.window.rootViewController.view addSubview:_adBannerView];
    _adBannerView.top = [self.window bounds].size.height;
}

-(void)initGA
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];//kGAILogLevelVerbose
    
    // Initialize tracker.
    id<GAITracker> tracker = [[GAI sharedInstance] trackerWithTrackingId:kGoogleAnalyticsId];
    NSLog(@"tracker.name = %@",tracker.name);
}

-(void)initCrashlytics
{
    [Crashlytics startWithAPIKey:@"665fd4e82c885d0c0e6aeb2e5b16dbc601560575"];
}

@end
