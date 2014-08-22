//
//  IMMainViewController.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMainViewController.h"
#import "IMAPIService.h"
#import "IMMainTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface IMMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UISegmentedControl *segControl;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *rankMovies;
@property (nonatomic,strong)NSMutableArray *thisweekMovies;
@property (nonatomic,strong)NSMutableArray *incomingMovies;
@property (nonatomic,strong)NSMutableArray *intheaterMovies;
@property (nonatomic,strong)NSMutableArray *tableDataSource;

@property (nonatomic)IMMovieListType type;
@property (nonatomic,weak)AFHTTPRequestOperation *currentRequest;

@end

@implementation IMMainViewController

#pragma  mark - Override

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    float padding = 10;
    
    self.segControl.width = self.view.width - 2*padding;
    self.segControl.height = 36;
    self.segControl.left = padding;
    self.segControl.top= padding;
    
    self.tableView.width = self.view.width;
    self.tableView.height = self.view.height - self.segControl.bottom;
    self.tableView.top= self.segControl.bottom;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"臺北票房",@"本週新片",@"即將上映",@"近期電影"]];
    self.segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(segmentedControlClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: self.segControl];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor =[UIColor clearColor];
    [self.tableView setContentInset:UIEdgeInsetsMake(10, 0, 10, 0)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[IMMainTableViewCell class] forCellReuseIdentifier:@"IMMainTableViewCell"];

    [self.view addSubview: self.tableView];
    
    self.type = IMMovieListTypeTPRank;
    [self apiGetMoviewListByType:self.type];
}

#pragma  mark - Private

-(void)updateTableView
{
    switch (self.type)
    {
        case IMMovieListTypeIncoming:
            self.tableDataSource = self.incomingMovies;
            break;
        case IMMovieListTypeInTheater:
            self.tableDataSource  = self.intheaterMovies;
            break;
        case IMMovieListTypeThisWeek:
            self.tableDataSource  = self.thisweekMovies;
            break;
        case IMMovieListTypeTPRank:
            self.tableDataSource  = self.rankMovies;
            break;
            
        default:
            break;
    }
    
    self.segControl.selectedSegmentIndex = self.type;
    [self.tableView reloadData];
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
}

-(void)setSoure:(NSMutableArray *)array ToType:(IMMovieListType)type
{
    switch (self.type)
    {
        case IMMovieListTypeIncoming:
            self.incomingMovies = array;
            break;
        case IMMovieListTypeInTheater:
            self.intheaterMovies= array;
            break;
        case IMMovieListTypeThisWeek:
            self.thisweekMovies= array;
            break;
        case IMMovieListTypeTPRank:
            self.rankMovies= array;
            break;
            
        default:
            break;
    }
}

-(void)segmentedControlClick
{
    self.type = self.segControl.selectedSegmentIndex;
    [self updateTableView];
    
    [self apiGetMoviewListByType:self.type];
}

#pragma  mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.tableDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    IMMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMMainTableViewCell" forIndexPath:indexPath];
    
    IMMovieModel *movieObj = [self.tableDataSource objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = movieObj.ch_name;
    [cell.coverImageView  setImageWithURL:[NSURL URLWithString:movieObj.thumbnail_small]];
    [cell.descriptionLabel setText:movieObj.description];
    [cell.imdbLabel setText:movieObj.imdbText];
    [cell.tomatoLabel setText:movieObj.tomatoText];
    [cell.dateLabel setText:movieObj.dateText];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}

#pragma  mark - API

-(void)apiGetMoviewListByType:(IMMovieListType)type
{
    [self.currentRequest cancel];
    
    self.currentRequest =
    [[IMAPIService sharedInstance] apiMovieListWithType:type
                                                success:^(AFHTTPRequestOperation *operation, id movieList) {
                                                    [self setSoure:movieList ToType:type];
                                                    [self updateTableView];
                                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    
                                                }];
}

-(void)test
{
    [[IMAPIService sharedInstance] apiMovieListWithType:IMMovieListTypeInTheater success:^(AFHTTPRequestOperation *operation, id movieList) {
        
        
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
