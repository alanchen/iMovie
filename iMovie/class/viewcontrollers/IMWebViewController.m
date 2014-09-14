//
//  IMWebViewController.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMWebViewController.h"
#import "UIViewController+Style.h"
#import "IMNaviSpinner.h"

@interface IMWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)NSString *url;

@end

@implementation IMWebViewController

+ (IMWebViewController *)webViewControllerWithUrl:(NSString *)url
{
    IMWebViewController *vc =[[IMWebViewController alloc] init];
    vc.url = url;
    
    return vc;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    _webView.width = self.view.width;
    _webView.height = self.view.height;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"鄉民看電影";
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    [[IMNaviSpinner sharedInstance] startAnimating];
    
    [self addBackButtonWithTarget:self selector:@selector(back)];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [[IMNaviSpinner sharedInstance] stopAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[IMNaviSpinner sharedInstance] stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[IMNaviSpinner sharedInstance] stopAnimating];
}


@end
