//
//  IMAPIService.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMAPIService.h"

@implementation IMAPIService

+(IMAPIService *)sharedInstance
{
    static IMAPIService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[IMAPIService alloc] init];
        [sharedInstance commonInit];
    });
    
    return sharedInstance;
}

-(void)commonInit
{
    NSURL *baseUrl = [NSURL URLWithString:@"http://enigmatic-meadow-8952.herokuapp.com/movie/"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseUrl];
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    serializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    manager.responseSerializer = serializer;
    
    self.manager = manager;
}

-(AFHTTPRequestOperation *)apiMovieListWithType:(IMMovieListType)type
                                        success:(void (^)(AFHTTPRequestOperation *operation, id movieList))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSString *path = @"";
    
    switch (type) {
        case IMMovieListTypeTPRank:
            path = @"tprank";
            break;
        case IMMovieListTypeThisWeek:
            path = @"thisweek";
            break;
        case IMMovieListTypeIncoming:
            path = @"incoming";
            break;
        case IMMovieListTypeInTheater:
            path = @"inthreater";
            break;
            
        default:
            break;
    }
    
    AFHTTPRequestOperation *op =
    [_manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
            success(operation, [IMMovieModel parseListData:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(operation, error);
    }];
    
    return op;
}

-(AFHTTPRequestOperation *)apiGetMovieArticleList:(IMMovieArticleType)type
                                            title:(NSString *)title
                                          success:(void (^)(AFHTTPRequestOperation *operation, id articleList))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableDictionary *params = [@{} mutableCopy];
    
    NSString *path;
    
    switch (type) {
        case IMMovieArticleTypeGood:
            path = @"good";
            break;
        case IMMovieArticleTypeNormal:
            path = @"normal";
            break;
        case IMMovieArticleTypeBad:
            path = @"bad";
            break;
        default:
            break;
    }
    
    if(title)
        [params setObject:title forKey:@"title"];
    
    if(path)
        [params setObject:title forKey:@"ctype"];
    
    AFHTTPRequestOperation *op =
    [_manager GET:@"ptt/article" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        if(success)
            success(operation, [IMMovieArticleModel parseListData:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(operation, error);
    }];
    
    return op;
}

-(AFHTTPRequestOperation *)apiMovieDetailWithMovieId:(NSString *)movieId
                                             success:(void (^)(AFHTTPRequestOperation *operation, IMMovieDetailModel *movie))success
                                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
     NSMutableDictionary *params = [@{} mutableCopy];
    
    if(movieId)
        [params setObject:movieId forKey:@"id"];
    
    AFHTTPRequestOperation *op =
    [_manager GET:@"detail" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success)
            success(operation, [IMMovieDetailModel parseModelData:responseObject]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure)
            failure(operation, error);
    }];
    
    return op;
}



@end
