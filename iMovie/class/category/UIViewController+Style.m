//
//  UIViewController+Style.m
//  iMovie
//
//  Created by alan on 2014/8/23.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "UIViewController+Style.h"

@implementation UIViewController(Style)


-(void)addBackButtonWithTarget:(id)target selector:(SEL)selector
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn sizeToFit];
    [backBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBackButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = customBackButton;
}

-(void)setNavigationBarBackgroundColor:(UIColor *)color
{
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)])
    {
        [self.navigationController.navigationBar setBarTintColor:color];
    }
    
    if([self.navigationController.navigationBar respondsToSelector:@selector(setTranslucent:)])
    {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
        
    self.navigationController.navigationBar.backgroundColor = color;
}

-(void)setTitleImage:(NSString *)image
{
    [self.navigationItem setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:image] ]];
}

+ (void)setNavigationTitleColor:(UIColor *)color
{
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               color,UITextAttributeTextColor,nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}



@end
