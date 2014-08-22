//
//  IMMovieModel.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMovieModel.h"
#import "NSDate+Format.h"

@implementation IMMovieModel

+(NSArray *)parseListData:(id)data
{
    return [ACModelParser parse:data toClass:[IMMovieModel class]];
}

-(void)printSelf
{
    NSLog(@"Id:%@ 片名:%@ 好雷:%d普雷:%d壞雷:%d",self._id,self.ch_name,self.gc,self.nc,self.bc);
}

-(NSString *)imdbText
{
    NSString *value =@"無資料";
    NSString *IMDB =@"IMDB:";
    
    if(self.imdb>0)
        value = [NSString stringWithFormat:@"%d",self.imdb];
    
    return [NSString stringWithFormat:@"%@ %@",IMDB,value];
}

-(NSString *)tomatoText
{
    NSString *value =@"無資料";
    NSString *TOMATO =@"爛番茄:";
    
    if(self.imdb>0)
        value = [NSString stringWithFormat:@"%d",self.tomato];
    
    return [NSString stringWithFormat:@"%@ %@",TOMATO,value];
}

-(NSString *)dateText
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.showtime*0.001];
    
    return [NSString stringWithFormat:@"上映日期: %@",[date prettyDate]];
}

-(NSMutableAttributedString *)commentAttributedText
{
    NSString *goodNumber = [NSString stringWithFormat:@"%d",self.gc];
    NSString *normalNumber = [NSString stringWithFormat:@"%d",self.nc];
    NSString *badNumber = [NSString stringWithFormat:@"%d",self.bc];
    
    NSString *goodText = [NSString stringWithFormat:@"%@好雷",goodNumber];
    NSString *normalText  = [NSString stringWithFormat:@"%@好雷",normalNumber];
    NSString *badText  = [NSString stringWithFormat:@"%@負雷",badNumber];
    
    NSString *text = [NSString stringWithFormat:@"鄉民指數:%@/%@/%@",goodText,normalText,badText];
    
    NSRange rangeGood = [text rangeOfString:goodText];
    rangeGood.length = goodNumber.length;
    NSRange rangeNormal = [text rangeOfString:normalText];
    rangeNormal.length = normalNumber.length;
    NSRange rangeBad = [text rangeOfString:badText];
    rangeBad.length = badNumber.length;
    NSRange rangeAll = [text rangeOfString:text];
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:text];
    [title addAttribute:(NSString *)NSFontAttributeName
                  value:(id) IMFont(14)
                  range:rangeAll];
    [title addAttribute:(NSString *)NSForegroundColorAttributeName
                  value:(id) [UIColor blackColor]
                  range:rangeAll];
    [title addAttribute:(NSString *)NSForegroundColorAttributeName
                  value:(id)  [UIColor redColor]
                  range:rangeGood];
    [title addAttribute:(NSString *)NSForegroundColorAttributeName
                  value:(id)  [UIColor blueColor]
                  range:rangeNormal];
    [title addAttribute:(NSString *)NSForegroundColorAttributeName
                  value:(id)  [UIColor greenColor]
                  range:rangeBad];
    
    
    if( !(self.gc == self.nc && self.nc == self.bc) )
    {
        NSInteger largest = self.gc;
        NSRange largeTextRange = rangeGood;
        if(self.nc> largest){
            largest = self.nc;
            largeTextRange = rangeNormal;
        }
        if(self.bc> largest){
            largeTextRange = rangeBad;
        }
        
        [title addAttribute:(NSString *)NSFontAttributeName
                      value:(id) IMBoldFont(20)
                      range:largeTextRange];
    }
    
    return title;
}


@end
