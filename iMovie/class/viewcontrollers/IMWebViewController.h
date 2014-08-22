//
//  IMWebViewController.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMWebViewController : UIViewController

@property (nonatomic,strong)UIWebView *webView;

+ (IMWebViewController *)webViewControllerWithUrl:(NSString *)url;

@end
