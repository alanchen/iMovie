//
//  IMNaviSpinner.m
//  iMovie
//
//  Created by alan on 2014/8/24.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMNaviSpinner.h"

@implementation IMNaviSpinner

+(IMNaviSpinner *)sharedInstance
{
    static IMNaviSpinner *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IMNaviSpinner alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        sharedInstance.hidesWhenStopped = YES;
        [sharedInstance stopAnimating];
    });
    
    return sharedInstance;
}

@end
