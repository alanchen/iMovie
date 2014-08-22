//
//  IMMovieDetailViewController.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMovieDetailViewController.h"
#import "AFNetworking.h"
#import "IMAPIService.h"
#import "IMFullImageTableViewCell.h"
#import "IMMovieInfoTableViewCell.h"
#import "IMPttTableViewCell.h"
#import "IMWebViewController.h"
#import "UIImageView+AFNetworking.h"


@interface IMMovieDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UISegmentedControl *segControl;

@property (nonatomic,strong)NSMutableArray *articles;

@end

@implementation IMMovieDetailViewController

#pragma  mark - Override

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.segControl.width = self.view.width ;
    self.segControl.height = 36;
    
    self.tableView.width = self.view.width;
    self.tableView.height = self.view.height - self.segControl.bottom;
    self.tableView.top= self.segControl.bottom;
    
}

- (id)initWithMovie:(IMMovieModel *)movie
{
    self = [super init];
    if (self){
        self.movie = movie;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"電影資訊",@"鄉民評論",@"圖輯"]];
    self.segControl.segmentedControlStyle = UISegmentedControlStylePlain;
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(segmentedControlClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview: self.segControl];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor =[UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[IMPttTableViewCell class] forCellReuseIdentifier:@"IMPttTableViewCell"];
    [self.tableView registerClass:[IMFullImageTableViewCell class] forCellReuseIdentifier:@"IMFullImageTableViewCell"];
    [self.tableView registerClass:[IMMovieInfoTableViewCell class] forCellReuseIdentifier:@"IMMovieInfoTableViewCell"];

    [self apiGetMovieDetail];
    [self apiGetPttArticles];
}

#pragma  mark - Private

-(void)segmentedControlClick
{
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointZero animated:NO];
}

#pragma  mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSInteger numberOfRows = 0;
    
    if(self.segControl.selectedSegmentIndex == 0){
        numberOfRows = 6;
    }
    else if(self.segControl.selectedSegmentIndex == 1){
        numberOfRows = [self.articles count];
    }
    else if(self.segControl.selectedSegmentIndex == 2){
        numberOfRows = [self.movieDetail.key_photos count];
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(self.segControl.selectedSegmentIndex == 0)
    {
        if(indexPath.row==0)
        {
            IMFullImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMFullImageTableViewCell" forIndexPath:indexPath];
            [cell.fullImageView setImageWithURL:[NSURL URLWithString:_movie.thumbnail_big]];
            
            return cell;
        }
        else
        {
            IMMovieInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMMovieInfoTableViewCell" forIndexPath:indexPath];
            
            if(indexPath.row==1){
                cell.titleLabel.text = @"英文名稱";
                cell.messageLabel.text = _movie.ori_name;
            }
            else if(indexPath.row==2){
                cell.titleLabel.text = @"影片長度";
                cell.messageLabel.text = _movieDetail.key_length;
            }
            else if(indexPath.row==3){
                cell.titleLabel.text = @"導演";
                cell.messageLabel.text = _movieDetail.key_director;
            }
            else if(indexPath.row==4){
                cell.titleLabel.text = @"演員";
                cell.messageLabel.text = _movieDetail.key_actors;
            }
            else if(indexPath.row==5){
                cell.titleLabel.text = @"劇情概要";
                cell.messageLabel.text = _movieDetail.key_full_desc;
            }
            
            return cell;
        }
    }
    else if(self.segControl.selectedSegmentIndex == 1)
    {
        IMPttTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMPttTableViewCell" forIndexPath:indexPath];
        
        IMMovieArticleModel *article = [self.articles objectAtIndex:indexPath.row];
        cell.titleLabel.text =article.key_title;
        [cell setPush:article.key_push];
        cell.idLabel.text = article.key_author;

        return cell;
    }
    else if(self.segControl.selectedSegmentIndex == 2)
    {
        IMFullImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMFullImageTableViewCell" forIndexPath:indexPath];
        NSString *imgeUrl = [self.movieDetail.key_photos objectAtIndex:indexPath.row];
        [cell.fullImageView setImageWithURL:[NSURL URLWithString:imgeUrl]];
        
        return cell;
    }

    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSInteger height = 0;
    
    if(self.segControl.selectedSegmentIndex == 0){
        
        if(indexPath.row==0){
            height = 453;
        }
        else if(indexPath.row==1){
            height = [IMMovieInfoTableViewCell cellHeightWithDetail:_movie.ori_name];
        }
        else if(indexPath.row==2){
            height = [IMMovieInfoTableViewCell cellHeightWithDetail:_movieDetail.key_length];
        }
        else if(indexPath.row==3){
            height = [IMMovieInfoTableViewCell cellHeightWithDetail:_movieDetail.key_director];
        }
        else if(indexPath.row==4){
            height = [IMMovieInfoTableViewCell cellHeightWithDetail:_movieDetail.key_actors];
        }
        else if(indexPath.row==5){
            height = [IMMovieInfoTableViewCell cellHeightWithDetail:_movieDetail.key_full_desc];
        }
    }
    else if(self.segControl.selectedSegmentIndex == 1){
        IMMovieArticleModel *article = [self.articles objectAtIndex:indexPath.row];
        height = [IMPttTableViewCell cellHeightWithDetail:article.key_title];
    }
    else if(self.segControl.selectedSegmentIndex == 2){
        height = 200;
    }
    
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.segControl.selectedSegmentIndex == 1)
    {
        IMMovieArticleModel *article = [self.articles objectAtIndex:indexPath.row];
        IMWebViewController *vc = [IMWebViewController webViewControllerWithUrl:article.url];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma  mark - API

-(void)apiGetMovieDetail
{
    [[IMAPIService sharedInstance] apiMovieDetailWithMovieId:self.movie._id
                                                     success:^(AFHTTPRequestOperation *operation, IMMovieDetailModel *movie) {
                                                         self.movieDetail = movie;
                                                         [self.tableView reloadData];
                                                     }
                                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                         
                                                     }];
    
}

-(void)apiGetPttArticles
{
    [[IMAPIService sharedInstance] apiGetMovieArticleList:IMMovieArticleTypeGood
                                                    title:self.movie.ch_name
                                                  success:^(AFHTTPRequestOperation *operation, id articleList) {
                                                      self.articles = articleList;
                                                      [self.tableView reloadData];
                                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      
                                                  }];
}

@end
