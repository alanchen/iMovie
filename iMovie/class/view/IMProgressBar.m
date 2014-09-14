//
//  IMProgressBar.m
//  iMovie
//
//  Created by alan on 2014/9/14.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMProgressBar.h"

@implementation IMProgressBar

+(IMProgressBar *)progressBar
{
    UIImage *green = [[UIImage imageNamed:@"progress_green"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    UIImage *pink = [[UIImage imageNamed:@"progress_pink"] resizableImageWithCapInsets:UIEdgeInsetsZero];

    IMProgressBar *p = [[IMProgressBar alloc] initWithFrame:CGRectZero];
    if (IS_OS_7_OR_LATER)
        p.tintColor = [UIColor clearColor];
    
    [p setTrackImage:green];
    [p setProgressImage:pink];
    
    return p;
}


@end
