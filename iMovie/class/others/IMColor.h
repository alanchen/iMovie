//
//  IMColor.h
//  iMovie
//
//  Created by alan on 2014/8/23.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#define UIColorRGBA(r,g,b,a) [UIColor colorWithRed:(float)r/(float)255 green:(float)g/(float)255 blue:(float)b/(float)255 alpha:a]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0                 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ColorThemeBlue  UIColorRGBA(63,81,181,1)
#define ColorThemeGray  UIColorRGBA(221,221,221,1)
#define ColorTextGray   UIColorRGBA(170,170,170,1)

#define ColorCommentRed  UIColorRGBA(255,0,0,1)
#define ColorCommentGreen  UIColorRGBA(0,158,0,1)
#define ColorCommentBlue  UIColorRGBA(0,0,255,1)
#define ColorCommentYellow  UIColorRGBA(250,255,0,1)


// new style
#define ColorThemeGreen  UIColorFromRGB(0x70c3c4)
#define ColorThemeYello  UIColorFromRGB(0xf1ac35)
#define ColorThemePink  UIColorFromRGB(0xd65096)
#define ColorThemeTextGray  UIColorFromRGB(0xa9a9a9)

