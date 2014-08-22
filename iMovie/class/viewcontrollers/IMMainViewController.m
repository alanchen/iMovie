//
//  IMMainViewController.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMainViewController.h"
#import "IMAPIService.h"

@interface IMMainViewController ()

@end

@implementation IMMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [[IMAPIService sharedInstance] apiMovieListWithType:IMMovieListTypeInTheater success:^(AFHTTPRequestOperation *operation, id movieList) {
//        
//        for(IMMovieModel *movie in movieList)
//            [movie printSelf];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [[IMAPIService sharedInstance] apiGetMovieArticleList:IMMovieArticleTypeGood title:@"猩球崛起" success:^(AFHTTPRequestOperation *operation, id articleList) {
        
//        for(IMMovieArticleModel *article in articleList)
//            [article printSelf];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [[IMAPIService sharedInstance] apiMovieDetailWithMovieId:@"5202" success:^(AFHTTPRequestOperation *operation, IMMovieDetailModel *movie) {
//        [movie printSelf];
//        NSLog(@"%@",movie.key_photos);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


@end
