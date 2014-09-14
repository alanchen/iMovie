//
//  IMMainViewController.m
//  iMovie
//
//  Created by alan on 2014/8/22.
//  Copyright (c) 2014年 alan. All rights reserved.
//

#import "IMMainViewController.h"
#import "IMAPIService.h"
#import "IMMainTableCell.h"
#import "UIImageView+AFNetworking.h"
#import "IMMovieDetailViewController.h"
#import "UIViewController+Style.h"
#import "IMErrorView.h"

@interface IMMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UISegmentedControl *segControl;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIActivityIndicatorView *spinner;
@property (nonatomic,strong)IMErrorView *errorView;

@property (nonatomic,strong)NSMutableArray *tpRankMovies;
@property (nonatomic,strong)NSMutableArray *currentMovie;
@property (nonatomic,strong)NSMutableArray *futureMovies;
@property (nonatomic,strong)NSMutableArray *tableDataSource;

@property (nonatomic)IMMovieListSort sortType;

@property (nonatomic,weak)AFHTTPRequestOperation *opTPRank;
@property (nonatomic,weak)AFHTTPRequestOperation *opIncoming;
@property (nonatomic,weak)AFHTTPRequestOperation *opDefault;

@end

@implementation IMMainViewController

#pragma  mark - Override

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    float padding = 10;
    float segWidth = self.view.width*1.5;
    float segHeight = 36;
    
    self.scrollView.width = self.view.width;
    self.scrollView.contentSize = CGSizeMake(segWidth, segHeight);
    self.scrollView.height = segHeight+2*padding;
    
    self.segControl.width = segWidth;
    self.segControl.height = segHeight;
    self.segControl.centerY = self.scrollView.height/2;
    
    self.tableView.width = self.view.width;
    self.tableView.height = self.view.height - self.segControl.bottom - padding;
    self.tableView.top= self.segControl.bottom+padding;
    
    self.spinner.centerX = self.tableView.width/2;
    self.spinner.centerY = self.tableView.height/2;

    self.errorView.centerX = self.view.width/2;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"鄉民看電影";
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setContentInset:UIEdgeInsetsMake(0,10,0,10)];
    [self.view addSubview: self.scrollView];

    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"人氣排序",@"好雷排序",@"負雷排序",@"臺北票房" ,@"IMDB",@"即將上映"]];
    self.segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segControl.tintColor =ColorThemeGreen;
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(segmentedControlClick) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview: self.segControl];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = ColorThemeGray;
    self.tableView.delaysContentTouches = NO;
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 10, 0)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[IMMainTableCell class] forCellReuseIdentifier:@"IMMainTableViewCell"];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.spinner startAnimating];
    self.spinner.hidesWhenStopped = YES;
    [self.tableView addSubview:self.spinner];
    
    self.errorView = [IMErrorView errorView];
    [self.tableView addSubview:self.errorView];
    [self.errorView.retryButton addTarget:self action:@selector(retryButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.errorView.top = 100;

    [self.view addSubview: self.tableView];
    
    self.sortType = IMMovieListSortHitto;
    
    [self apiGetCurrentMovieList];
    [self apiGetFutureMovieList];
    [self apiGetTPRankMovieList];

    [self updateTableView];
}

#pragma  mark - Private

-(void)updateTableView
{
    BOOL isLoading = NO;
    
    self.segControl.selectedSegmentIndex = self.sortType;
    
    switch (self.sortType)
    {
        case IMMovieListSortHitto:
        {
            self.tableDataSource = [self sortDataSource:self.currentMovie byType:self.sortType];
            isLoading = self.opDefault.isExecuting;
            break;
        }
        case IMMovieListSortGood:
        {
            self.tableDataSource = [self sortDataSource:self.currentMovie byType:self.sortType];
            isLoading = self.opDefault.isExecuting;
            break;
        }
        case IMMovieListSortBad:
        {
            self.tableDataSource = [self sortDataSource:self.currentMovie byType:self.sortType];
            isLoading = self.opDefault.isExecuting;
            break;
        }
        case IMMovieListSortIMDB:
        {
            self.tableDataSource = [self sortDataSource:self.currentMovie byType:self.sortType];
            isLoading = self.opDefault.isExecuting;
            break;
        }
        case IMMovieListSortTPRank:
        {
            self.tableDataSource  = self.tpRankMovies;
            isLoading = self.opTPRank.isExecuting;
            break;
        }
        case IMMovieListSortIncoming:
        {
            self.tableDataSource  = self.futureMovies;
            isLoading = self.opIncoming.isExecuting;
            break;
        }
        default:
            break;
    }
    
    if(isLoading)
    {
        [self.spinner startAnimating];
        self.errorView.hidden  = YES;
        return;
    }
    else
    {
        [self.spinner stopAnimating];
        self.errorView.hidden  = NO;
    }
    
    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    
    if( [self.tableDataSource count] ){
        self.errorView.hidden  = YES;
    }
    else{
        self.errorView.hidden  = NO;
    }
}

-(NSMutableArray *)sortDataSource:(NSMutableArray *)dataSource byType:(IMMovieListSort)type
{
    NSString *key = @"gc";
    
    if(type == IMMovieListSortGood)
        key = @"gc";
    else if(type == IMMovieListSortBad)
        key = @"bc";
    else if(type == IMMovieListSortHitto)
        key = @"total";
    else if(type == IMMovieListSortIMDB)
        key = @"imdb";
    
    NSSortDescriptor *sortDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:key
                                  ascending:NO
                                 comparator:^NSComparisonResult(id obj1, id obj2) {
                                     
                                     int value1 = [obj1 integerValue];
                                     int value2 = [obj2 integerValue];
                                     
                                     if (value1 < value2) {
                                         return NSOrderedAscending;
                                     }
                                     else if (value1 > value2){
                                         return NSOrderedDescending;
                                     }
                                     else {
                                         return NSOrderedSame;
                                     }
                                 }];
    
    return [[dataSource sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
}

-(void)segmentedControlClick
{
    self.sortType = self.segControl.selectedSegmentIndex;
    [self updateTableView];
}

-(void)retryButtonClicked
{
    if(self.sortType == IMMovieListSortHitto ||
       self.sortType == IMMovieListSortGood ||
       self.sortType == IMMovieListSortBad ||
       self.sortType == IMMovieListSortIMDB )
    {
        [self apiGetCurrentMovieList];
    }
    else if(self.sortType == IMMovieListSortTPRank)
    {
        [self apiGetFutureMovieList];
    }
    else if(self.sortType == IMMovieListSortIncoming)
    {
        [self apiGetTPRankMovieList];
    }
}

#pragma  mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.tableDataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    IMMainTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IMMainTableViewCell" forIndexPath:indexPath];
    
    IMMovieModel *movieObj = [self.tableDataSource objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = movieObj.ch_name;
    cell.engTitleLabel.text = movieObj.ori_name;

    [cell.coverImageView  setImageWithURL:[NSURL URLWithString:movieObj.thumbnail_small] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [cell.pttIndexLabel setAttributedText:movieObj.pttIndexText];
    [cell.indexLabel setText:[NSString stringWithFormat:@"%d",indexPath.row+1]];
    [cell.goodIndexLabel setText:[NSString stringWithFormat:@"%d",movieObj.gc]];
    [cell.badIndexLabel setText:[NSString stringWithFormat:@"%d",movieObj.bc]];
    [cell.imdbLabel setText:movieObj.imdbText];
    [cell.yahooLabel setText:movieObj.tomatoText];
    [cell.dateLabel setText:movieObj.dateText];
    [cell setProgressWithGood:movieObj.gc bad:movieObj.bc];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 215;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IMMovieModel *movieObj = [self.tableDataSource objectAtIndex:indexPath.row];
    
    IMMovieDetailViewController *vc =[[IMMovieDetailViewController alloc] initWithMovie:movieObj];
    [self.navigationController pushViewController:vc animated:YES];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma  mark - API

-(void)apiGetCurrentMovieList
{
    self.opDefault =
    [[IMAPIService sharedInstance] apiGetCurrentMoviesWithSuccess:^(AFHTTPRequestOperation *operation, id movieList) {
        self.currentMovie = movieList;
        [self updateTableView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(error.code != -999)
            [SVProgressHUD showErrorWithStatus:@"加載失敗，請檢查網路"];
         [self updateTableView];
    }];
    
    [self updateTableView];
}

-(void)apiGetFutureMovieList
{
     self.opIncoming =
    [[IMAPIService sharedInstance] apiGetFutureMoviesWithSuccess:^(AFHTTPRequestOperation *operation, id movieList) {
        self.futureMovies = [[movieList reversedArray] mutableCopy];
        [self updateTableView];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(error.code != -999)
            [SVProgressHUD showErrorWithStatus:@"加載失敗，請檢查網路"];
         [self updateTableView];
    }];
    
    [self updateTableView];
}

-(void)apiGetTPRankMovieList
{
    self.opTPRank =
    [[IMAPIService sharedInstance] apiMovieListWithType:IMMovieListTypeTPRank
                                                success:^(AFHTTPRequestOperation *operation, id movieList) {
                                                    self.tpRankMovies = movieList;
                                                    [self updateTableView];
                                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    if(error.code != -999)
                                                        [SVProgressHUD showErrorWithStatus:@"加載失敗，請檢查網路"];
                                                     [self updateTableView];
                                                }];
    
    [self updateTableView];
}

@end
