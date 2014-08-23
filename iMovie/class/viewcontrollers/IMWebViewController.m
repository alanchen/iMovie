//
//  IMWebViewController.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMWebViewController.h"
#import "UIViewController+Style.h"

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
    _webView.frame = self.view.frame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    _webView.delegate = self;
    [self.view addSubview:_webView];
   
    [self addBackButtonWithTarget:self selector:@selector(back)];
    
    [SVProgressHUD show];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [SVProgressHUD dismiss];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"加載失敗，請稍後再試"];
}


@end
