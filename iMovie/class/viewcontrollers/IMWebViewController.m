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
@property (nonatomic,strong)UIActivityIndicatorView *spinner;


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
    
    self.spinner.centerY = self.navigationController.navigationBar.height/2;
    self.spinner.right = self.navigationController.navigationBar.width-10;
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    _webView.delegate = self;
    [self.view addSubview:_webView];
   
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self.spinner startAnimating];
    [self.navigationController.navigationBar addSubview:self.spinner];
    
    [self addBackButtonWithTarget:self selector:@selector(back)];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner setHidden:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:@"加載失敗，請稍後再試"];
    [self.spinner setHidden:YES];
}


@end
