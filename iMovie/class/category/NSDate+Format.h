//
//  NSDate+Format.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Format)

- (NSString *)prettyDate;
- (NSString *)displayDateFormat:(NSString *)Format; // yyyy/MM/dd


@end
