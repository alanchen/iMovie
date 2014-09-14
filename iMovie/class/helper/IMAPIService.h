//
//  IMAPIService.h
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "IMMovieModel.h"
#import "IMMovieArticleModel.h"
#import "IMMovieDetailModel.h"

@interface IMAPIService : NSObject

@property (nonatomic,strong)AFHTTPRequestOperationManager *manager;

+(IMAPIService *)sharedInstance;

-(AFHTTPRequestOperation *)apiMovieListWithType:(IMMovieListType)type
                                        success:(void (^)(AFHTTPRequestOperation *operation, id movieList))success
                                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(AFHTTPRequestOperation *)apiGetMovieArticleList:(IMMovieArticleType)type
                                            title:(NSString *)title
                                          success:(void (^)(AFHTTPRequestOperation *operation, id articleList))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(AFHTTPRequestOperation *)apiMovieDetailWithMovieId:(NSString *)movieId
                                          success:(void (^)(AFHTTPRequestOperation *operation, IMMovieDetailModel *movie))success
                                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


-(AFHTTPRequestOperation *)apiGetCurrentMoviesWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id movieList))success
                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(AFHTTPRequestOperation *)apiGetFutureMoviesWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id movieList))success
                                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
