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
    UIBarButtonItem *customBackButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:target
                                                                        action:selector];
    
    [customBackButton setTintColor:[UIColor whiteColor]];
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






@end
