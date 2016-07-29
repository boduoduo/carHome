//
//  RecommendViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "RecommendViewController.h"
#import "MJRefresh.h"
#import "UIImageView+Remote.h"
#import "AppService.h"
#import "New1TableViewCell.h"
#import "New2TableViewCell.h"
#import "TitleNew1VO.h"
#import "ADNew1VO.h"
#import "NewNew1VO.h"
#import "BulletinVO.h"
#import "videoVO.h"
#import "NewsVO.h"
#import "TestVO.h"
#import "bulletinTableViewCell.h"
#import "BrandViewController.h"
#import "NSStringHelp.h"
#import "ModelCarViewController.h"
#import "videoViewController.h"
#import "WebViewController.h"
#import "NewNew1DAO1.h"
#import "BulletinDAO1.h"
#import "videoDAO1.h"
#import "newsDAO1.h"
#import "TestDAO1.h"
#import "AdScrollView.h"
#define BUTTON_WIDTH 50
#define BUTTON_DISTANCE 20
#define BUTTON_LEFT 10
#define BUTTON_HIGHT 40
@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ModelCarDelegate,BrandDelegate,videoDelegate>{
    __weak IBOutlet UIScrollView * topScrollView;
    __weak IBOutlet UIScrollView * bottomScrollView;
    UIButton *titlebtn0;
    UIButton *titlebtn1;
    UIButton *titlebtn2;
    UIButton *titlebtn3;
    UIButton *titlebtn4;
    NSMutableArray * resultArr1;
    NSMutableArray * resultArr2;
    NSMutableArray * resultArr3;
    NSMutableArray * resultArr4;
    NSMutableArray * resultArr5;
    NSMutableArray * imageArr;
    UITableView *oneTableview;
    UITableView *towTableview;
    UITableView *threeTableview;
    UITableView *fourTableview;
    UITableView *fiveTableview;
    UIButton * _bulletinButton;
    UIButton * _bulletinButton2;
    UIButton * _bulletinButton3;
    AdScrollView * adScrollView;
    UIActivityIndicatorView * _indicator;
    int num;
    int num1;
    int num2;
    int num3;
    int num4;
    int levelid;
    int b;
    int vt;
}

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    resultArr1 = [NSMutableArray array];
    resultArr2 = [NSMutableArray array];
    resultArr3 = [NSMutableArray array];
    resultArr4 = [NSMutableArray array];
    resultArr5 = [NSMutableArray array];
    imageArr = [NSMutableArray array];
    levelid = 0;
    b = 0;
    vt =0;
    [self refreshData];
    [self createADView];
    [super viewDidLoad];
    [self configUI];
    [self loadAnimation];
}
#pragma mark 加载数据
-(void)refreshData{
    num= 0;
    [self requestFirstPageSearchApps:num];
}
-(void)getNextData{
    num++;
    [self requestNextPageSearchApps:num];
}


-(void)refreshData1{
    num1= 0;
    [self requestFirstPageSearchApps1:num1];
}
-(void)getNextData1{
    num1++;
    [self requestNextPageSearchApps1:num1];
}


-(void)refreshData2{
    num2= 0;
    [self requestFirstPageSearchApps2:num1];
}
-(void)getNextData2{
    num2++;
    [self requestNextPageSearchApps2:num1];
}

-(void)refreshData3{
    num3= 0;
    [self requestFirstPageSearchApps3:num1];
}
-(void)getNextData3{
    num3++;
    [self requestNextPageSearchApps3:num1];
}

-(void)refreshData4{
    num4= 0;
    [self requestFirstPageSearchApps4:num1];
}
-(void)getNextData4{
    num4++;
    [self requestNextPageSearchApps4:num1];
}
#pragma mark 数据请求
-(void)requestFirstPageSearchApps:(int)p {
    [[[AppService alloc]init]getRecommendAppByNum:p handle:^(id result) {
        resultArr1 = result;
        if (resultArr1.count>0) {
            [_indicator stopAnimating];
        }
        [oneTableview reloadData];
        adScrollView.bannerArray = resultArr1[1];
        [adScrollView setNeedsDisplay];
        //判断是否还在加载。。。。。，如果是就停止
        if (oneTableview.header.isRefreshing) {
            [oneTableview.header endRefreshing];
        }
    }];
}

-(void)requestNextPageSearchApps:(int)p {
    // 如果要在block里面去使用self的时候，需要注意避免强引用环，处理方式如下：
    
    [[[AppService alloc]init]getRecommendAppByNum:p  handle:^(id result) {
        [resultArr1 addObjectsFromArray:result];
        [oneTableview reloadData];
        // 判断是否还在加载中。。。，如果是就停止
        if (oneTableview.footer.isRefreshing) {
            [oneTableview.footer endRefreshing];
        }
    }];
}

-(void)requestFirstPageSearchApps1:(int)p {
    [[[AppService alloc]init]getRecommend1AppByNum:p b:b levelid:levelid handle:^(id result) {
        resultArr2 = result;
        if (resultArr2.count>0) {
            [_indicator stopAnimating];
        }
        [towTableview reloadData];
        //判断是否还在加载。。。。。，如果是就停止
        if (towTableview.header.isRefreshing) {
            [towTableview.header endRefreshing];
        }
    }];
}

-(void)requestNextPageSearchApps1:(int)p {
    // 如果要在block里面去使用self的时候，需要注意避免强引用环，处理方式如下：
    
    [[[AppService alloc]init]getRecommend1AppByNum:p b:b levelid:levelid handle:^(id result) {
        [resultArr2 addObjectsFromArray:result];
        [towTableview reloadData];
        // 判断是否还在加载中。。。，如果是就停止
        if (towTableview.footer.isRefreshing) {
            [towTableview.footer endRefreshing];
        }
    }];
}

-(void)requestFirstPageSearchApps2:(int)p {
    [[[AppService alloc]init]getRecommend2AppByNum:p vt:vt handle:^(id result) {
        resultArr3 = result;
        if (resultArr3.count>0) {
            [_indicator stopAnimating];
        }
        [threeTableview reloadData];
        //判断是否还在加载。。。。。，如果是就停止
        if (threeTableview.header.isRefreshing) {
            [threeTableview.header endRefreshing];
        }
    }];
}

-(void)requestNextPageSearchApps2:(int)p {
    // 如果要在block里面去使用self的时候，需要注意避免强引用环，处理方式如下：
    
    [[[AppService alloc]init]getRecommend2AppByNum:p vt:vt handle:^(id result) {
        [resultArr3 addObjectsFromArray:result];
        [towTableview reloadData];
        // 判断是否还在加载中。。。，如果是就停止
        if (towTableview.footer.isRefreshing) {
            [towTableview.footer endRefreshing];
        }
    }];
}

-(void)requestFirstPageSearchApps3:(int)p {
    [[[AppService alloc]init]getRecommend3AppByNum:p handle:^(id result) {
        resultArr4 = result;
        if (resultArr1.count>0) {
            [_indicator stopAnimating];
        }
        [fourTableview reloadData];
        //判断是否还在加载。。。。。，如果是就停止
        if (fourTableview.header.isRefreshing) {
            [fourTableview.header endRefreshing];
        }
    }];
}

-(void)requestNextPageSearchApps3:(int)p {
    // 如果要在block里面去使用self的时候，需要注意避免强引用环，处理方式如下：
    
    [[[AppService alloc]init]getRecommend3AppByNum:p  handle:^(id result) {
        [resultArr4 addObjectsFromArray:result];
        [fourTableview reloadData];
        // 判断是否还在加载中。。。，如果是就停止
        if (fourTableview.footer.isRefreshing) {
            [fourTableview.footer endRefreshing];
        }
    }];
}

-(void)requestFirstPageSearchApps4:(int)p {
    [[[AppService alloc]init]getRecommend4AppByNum:p handle:^(id result) {
        resultArr5 = result;
        if (resultArr1.count>0) {
            [_indicator stopAnimating];
        }
        [fiveTableview reloadData];
        //判断是否还在加载。。。。。，如果是就停止
        if (fiveTableview.header.isRefreshing) {
            [fiveTableview.header endRefreshing];
        }
    }];
}

-(void)requestNextPageSearchApps4:(int)p {
    // 如果要在block里面去使用self的时候，需要注意避免强引用环，处理方式如下：
    
    [[[AppService alloc]init]getRecommend4AppByNum:p  handle:^(id result) {
        [resultArr5 addObjectsFromArray:result];
        [fiveTableview reloadData];
        // 判断是否还在加载中。。。，如果是就停止
        if (fiveTableview.footer.isRefreshing) {
            [fiveTableview.footer endRefreshing];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)createADView{
    adScrollView = [[AdScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,200)];
    adScrollView.PageControlShowStyle = UIPageControlShowStyleCenter;
    adScrollView.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    adScrollView.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
}
-(void)configUI{
    for (int i = 0; i<5; i++) {
        UIButton * btnList = [UIButton buttonWithType:UIButtonTypeCustom];
        btnList.frame = CGRectMake(BUTTON_LEFT+BUTTON_WIDTH*i, 0, BUTTON_WIDTH, BUTTON_HIGHT);
        [btnList setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnList addTarget:self action:@selector(topClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnList.titleLabel.font = [UIFont systemFontOfSize:15];
        if (i==0) {
            [btnList setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            [btnList setTitle:@"最新" forState:UIControlStateNormal];
            btnList.tag = 300;
            titlebtn0 = btnList;
        }else if (i==1){
            [btnList setTitle:@"快报" forState:UIControlStateNormal];
            btnList.tag = 301;
            titlebtn1 = btnList;
        }else if (i==2){
            [btnList setTitle:@"视频" forState:UIControlStateNormal];
            btnList.tag = 302;
            titlebtn2 = btnList;
        }else if (i==3){
            [btnList setTitle:@"新闻" forState:UIControlStateNormal];
            btnList.tag = 303;
            titlebtn3 = btnList;
        }else {
            [btnList setTitle:@"评测" forState:UIControlStateNormal];
            btnList.tag = 304;
            titlebtn4 = btnList;
        }
        [topScrollView addSubview:btnList];
    }
    topScrollView.contentSize = CGSizeMake(BUTTON_WIDTH*5, BUTTON_HIGHT);
    
    //UITableView的创建
    for (int i = 0; i <5; i++) {
        CGFloat hightTop  ;
        if (i==1||i ==2) {
            hightTop = 40;
        }else{
            hightTop = 0;
        }
        UITableView * cellTableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*i, hightTop, self.view.bounds.size.width, self.view.bounds.size.height-44-20) style:UITableViewStylePlain];
        cellTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cellTableView.tableFooterView = [[UIView alloc]init];
        
        if (i == 0) {
            oneTableview = cellTableView;
            //创建广告头
            oneTableview.tableHeaderView = adScrollView;
            [oneTableview registerNib:[UINib nibWithNibName:@"New1TableViewCell" bundle:nil] forCellReuseIdentifier:@"New1TableViewCell"];
            [oneTableview registerNib:[UINib nibWithNibName:@"New2TableViewCell" bundle:nil] forCellReuseIdentifier:@"New2TableViewCell"];
            
            __block RecommendViewController *blockSelf = self;
            //添加下拉刷新
            oneTableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [blockSelf refreshData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [oneTableview.header endRefreshing];
                });
            }];
            //添加上拉加载更多
            oneTableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self getNextData];
                // 表示N = 5秒之后结束Refreshing
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [oneTableview.footer endRefreshing];
                });
            }];
            
            
        }else if (i==1){
            towTableview = cellTableView;
            [towTableview registerNib:[UINib nibWithNibName:@"bulletinTableViewCell" bundle:nil] forCellReuseIdentifier:@"bulletinTableViewCell"];
            __block RecommendViewController *blockSelf = self;
            //添加下拉刷新
            towTableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [blockSelf refreshData1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [towTableview.header endRefreshing];
                });
            }];
            //添加上拉加载更多
            towTableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self getNextData1];
                // 表示N = 5秒之后结束Refreshing
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [towTableview.footer endRefreshing];
                });
            }];
        }else if(i==2){
            threeTableview = cellTableView;
            [threeTableview registerNib:[UINib nibWithNibName:@"New1TableViewCell" bundle:nil] forCellReuseIdentifier:@"New1Cell1"];
            __block RecommendViewController *blockSelf = self;
            //添加下拉刷新
            threeTableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [blockSelf refreshData2];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [threeTableview.header endRefreshing];
                });
            }];
            //添加上拉加载更多
            threeTableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self getNextData2];
                // 表示N = 5秒之后结束Refreshing
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [threeTableview.footer endRefreshing];
                });
            }];
        }else if(i==3){
            fourTableview = cellTableView;
            [fourTableview registerNib:[UINib nibWithNibName:@"New1TableViewCell" bundle:nil] forCellReuseIdentifier:@"New1Cell2"];
            [fourTableview registerNib:[UINib nibWithNibName:@"New2TableViewCell" bundle:nil] forCellReuseIdentifier:@"New2Cell"];
            __block RecommendViewController *blockSelf = self;
            //添加下拉刷新
            fourTableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [blockSelf refreshData3];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [fourTableview.header endRefreshing];
                });
            }];
            //添加上拉加载更多
            fourTableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self getNextData3];
                // 表示N = 5秒之后结束Refreshing
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [fourTableview.footer endRefreshing];
                });
            }];
        }else{
            fiveTableview = cellTableView;
            [fiveTableview registerNib:[UINib nibWithNibName:@"New1TableViewCell" bundle:nil] forCellReuseIdentifier:@"New1Cell3"];
            __block RecommendViewController *blockSelf = self;
            //添加下拉刷新
            fiveTableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [blockSelf refreshData4];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [fiveTableview.header endRefreshing];
                });
            }];
            //添加上拉加载更多
            fiveTableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                [self getNextData4];
                // 表示N = 5秒之后结束Refreshing
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [fiveTableview.footer endRefreshing];
                });
            }];
        }
        [bottomScrollView addSubview:cellTableView];
        cellTableView.delegate = self;
        cellTableView.dataSource = self;
    }
    //bulletinView的创建
    UIView * bulletinView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, 40)];
    UIButton *bulletinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _bulletinButton = bulletinButton;
    bulletinButton.frame = CGRectMake(10, 0,70, 40);
    [bulletinButton setTitle:@"全部品牌" forState:UIControlStateNormal];
    [bulletinButton setImage:[UIImage imageNamed:@"main_filter_icon_f"] forState:UIControlStateNormal];
    //设置image在button上的位置（上top，左left，下bottom，右right）这里可以写负值，对上写－5，那么image就象上移动5个像素 (button.titleEdgeInsets)
    bulletinButton.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-110);
    bulletinButton.titleEdgeInsets =UIEdgeInsetsMake(0, -20, 0, 0);
    [bulletinButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bulletinButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [bulletinButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    bulletinButton.tag = 100;
    [bulletinView addSubview:bulletinButton];
    
    UIButton *bulletinButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _bulletinButton2 = bulletinButton2;
    [bulletinButton2 setTitle:@"全部级别" forState:UIControlStateNormal];
    [bulletinButton2 setImage:[UIImage imageNamed:@"main_filter_icon_f"] forState:UIControlStateNormal];
    bulletinButton2.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-110);
    bulletinButton2.titleEdgeInsets =UIEdgeInsetsMake(0, -20, 0, 0);
    bulletinButton2.frame = CGRectMake(100, 0,70, 40);
    [bulletinView addSubview:bulletinButton2];
    [bulletinButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bulletinButton2.titleLabel.font = [UIFont systemFontOfSize:12];
    [bulletinButton2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    bulletinButton2.tag =101;
    [bottomScrollView addSubview:bulletinView];
    
    UIView * bulletinView1 = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, 40)];
    UIButton *bulletinButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _bulletinButton3 = bulletinButton3;
    [bulletinButton3 setTitle:@"全部" forState:UIControlStateNormal];
    [bulletinButton3 setImage:[UIImage imageNamed:@"main_filter_icon_f"] forState:UIControlStateNormal];
    bulletinButton3.imageEdgeInsets = UIEdgeInsetsMake(0,0,0,-70);
    bulletinButton3.titleEdgeInsets =UIEdgeInsetsMake(0, -20, 0, 0);
    bulletinButton3.frame = CGRectMake(10, 0,40, 40);
    [bulletinView1 addSubview:bulletinButton3];
    [bulletinButton3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    bulletinButton3.titleLabel.font = [UIFont systemFontOfSize:12];
    [bulletinButton3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    bulletinButton3.tag =102;
    [bottomScrollView addSubview:bulletinView1];
    
    //bottomScrollView的设置
    bottomScrollView.contentSize = CGSizeMake(self.view.bounds.size.width*5,0);
    bottomScrollView.pagingEnabled = YES;
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    bottomScrollView.bounces = NO;
    bottomScrollView.delegate = self;
    bottomScrollView.contentOffset = CGPointMake(0, 0);
}
//界面转换
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/bottomScrollView.bounds.size.width;
    if (index == 0) {
        [self refreshData];
    }else if (index ==1) {
        [self refreshData1];
    }else if (index ==2){
        [self refreshData2];
    }else if (index ==3){
        [self refreshData3];
    }else {
        [self refreshData4];
    }
    [self setFontColorNumber:(int)index];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == oneTableview) {
        if (resultArr1.count > 0) {
            return [resultArr1[2] count];
        }
    }else if (tableView==towTableview) {
        if (resultArr2.count >0) {
            return [resultArr2 count];
        }
    }else if (tableView ==threeTableview){
        if (resultArr3.count >0) {
            return [resultArr3 count];
        }
    }else if (tableView ==fourTableview){
        if (resultArr4.count >0) {
            return [resultArr4 count];
        }
        
    }else if (tableView ==fiveTableview){
        if (resultArr5.count >0) {
            return [resultArr5 count];
        }
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==oneTableview) {
        NewNew1VO *model =resultArr1[2][indexPath.row];
        if ([model.indexdetail containsString:@".jpg"]) {
            return 120;
        }else{
            return 70;
        }
    }else if(tableView==towTableview){
        return 200;
    }else if (tableView ==threeTableview){
        return 70;
    }else if (tableView == fourTableview){
        NewsVO*model =resultArr4[indexPath.row];
        if ([model.indexdetail containsString:@".jpg"]) {
            return 120;
        }else{
            return 70;
        }
    }else if (tableView == fiveTableview){
        return 70;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == oneTableview) {
        if (resultArr1.count > 0)
        {NewNew1VO *model =resultArr1[2][indexPath.row];
            if ([model.indexdetail containsString:@".jpg"]){
                New2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"New2TableViewCell"forIndexPath:indexPath];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
                //图片
                NSArray *arr = [[[NSStringHelp alloc]init]photoString:model.indexdetail];
                if (arr[0]) {
                    [cell.iconImage1 setImageWithURLString:arr[0]];
                }
                if (arr[1]) {
                    [cell.iconImage2 setImageWithURLString:arr[1]];
                }
                if (arr[2]) {
                    [cell.iconImage3 setImageWithURLString:arr[2]];
                }
                cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
                if (model.type.length>1) {
                    cell.decriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
                }
                return cell;
            }else{
                New1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"New1TableViewCell"forIndexPath:indexPath];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
                [cell.iconImage setImageWithURLString:model.smallpic];
                cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
                if (model.type.length>1) {
                    cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
                }
                return cell;
            }
        }
    }else if(tableView ==towTableview){
        BulletinVO * model = resultArr2[indexPath.row];
        bulletinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bulletinTableViewCell" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.typenameLabel.text = [NSString stringWithFormat:@"%@",model.appTypename];
        if (model.state.intValue ==1) {
            cell.stateLabel.text = @"正在直播";
        }else{
            cell.stateLabel.text = @"播报结束";
        }
        cell.titlelabel.text = [NSString stringWithFormat:@"%@",model.title];
        cell.reviewcountLabel.text = [NSString stringWithFormat:@"%@位观众",model.reviewcount];
        [cell.iconImage setImageWithURLString:model.bgimage];
        cell.advancetimeLabel.text = [NSString stringWithFormat:@"%@",model.advancetime];
        return cell;
    }else if(tableView ==threeTableview){
        videoVO * model = resultArr3[indexPath.row];
        New1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"New1Cell1" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
        [cell.iconImage setImageWithURLString:model.smallimg];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
        return cell;
    }else if (tableView == fourTableview) {
        NewsVO *model =resultArr4[indexPath.row];
        if ([model.indexdetail containsString:@".jpg"]) {
            New2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"New2Cell"forIndexPath:indexPath];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
            //图片
            NSArray *arr = [[[NSStringHelp alloc]init]photoString:model.indexdetail];
            if (arr[0]) {
                [cell.iconImage1 setImageWithURLString:arr[0]];
            }
            if (arr[1]) {
                [cell.iconImage2 setImageWithURLString:arr[1]];
            }
            if (arr[2]) {
                [cell.iconImage3 setImageWithURLString:arr[2]];
            }
            cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
            if (model.type.length>1) {
                cell.decriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
            }
            return cell;
            
        }else{
            New1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"New1Cell2"forIndexPath:indexPath];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
            [cell.iconImage setImageWithURLString:model.smallpic];
            cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
            if (model.type.length>1){
                cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
            }
            return cell;
        }
    }else if (tableView == fiveTableview){
        TestVO * model = resultArr5[indexPath.row];
        New1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"New1Cell3" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
        [cell.iconImage setImageWithURLString:model.smallpic];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController * WVC = [[WebViewController alloc]init];
    if (tableView == oneTableview) {
        if (resultArr1.count > 0){
            NewNew1VO *model =resultArr1[2][indexPath.row];
            [[[NewNew1DAO1 alloc]init] save:resultArr1[2][indexPath.row]];
            WVC.newsId = model.appId;
            WVC.mediatypeString = model.mediatype;
        }
    }else if (tableView == towTableview){
        BulletinVO * model = resultArr2[indexPath.row];
        [[[BulletinDAO1 alloc]init]save:resultArr2[indexPath.row]];
        WVC.newsId = model.appId;
    }else if (tableView == threeTableview){
        videoVO * model = resultArr3[indexPath.row];
        [[[videoDAO1 alloc]init]save:resultArr3[indexPath.row]];
        WVC.newsId = model.appId;
        WVC.videoAddressString = model.videoaddress;
    }else if (tableView == fourTableview){
        NewsVO *model =resultArr4[indexPath.row];
        [[[newsDAO1 alloc]init]save:resultArr4[indexPath.row]];
        WVC.newsId = model.appId;
    }else{
        TestVO * model = resultArr5[indexPath.row];
        [[[TestDAO1 alloc]init]save:resultArr5[indexPath.row]];
        WVC.newsId = model.appId;
    }
    [self presentViewController:WVC animated:YES completion:nil];
}

-(void)btnClick:(id)sender{
    if ([(UIButton *)sender tag]== 100) {
        BrandViewController *BVC = [[BrandViewController alloc]init];
        BVC.brandDelegate = self;
        [self presentViewController:BVC animated:YES completion:nil];
    }else if([(UIButton *)sender tag]== 101){
        ModelCarViewController *MCVC = [[ModelCarViewController alloc]init];
        //代理
        MCVC.modelCarDelegate = self;
        [self presentViewController:MCVC animated:YES completion:nil];
    }else{
        videoViewController * VVC = [[videoViewController alloc]init];
        VVC.videoDelegate = self;
        [self presentViewController:VVC animated:YES completion:nil];
    }
}

//实现其他界面的代理
-(void)reciveBrandData:(int)data string:(NSString *)str{
    b = data;
    [_bulletinButton setTitle:str forState:UIControlStateNormal];
    [self refreshData1];
}

-(void)reciveModelCarData:(int)data string:(NSString *)str{
    levelid = data;
    [_bulletinButton2 setTitle:str forState:UIControlStateNormal];
    [self refreshData1];
}

-(void)reciveVideoData:(int)data string:(NSString *)str{
    vt = data;
    [_bulletinButton3 setTitle:str forState:UIControlStateNormal];
    [self refreshData2];
}

//上面btn响应事件
-(void)topClicked:(UIButton *)sender{
    if (sender.tag == 300) {
        [bottomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self setFontColorNumber:0];
        [self refreshData];
    }else if (sender.tag == 301){
        [bottomScrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:YES];
        [self setFontColorNumber:1];
        [self refreshData1];
    }else if (sender.tag == 302){
        [bottomScrollView setContentOffset:CGPointMake(self.view.bounds.size.width*2, 0) animated:YES];
        [self setFontColorNumber:2];
        [self refreshData2];
    }else if (sender.tag == 303){
        [bottomScrollView setContentOffset:CGPointMake(self.view.bounds.size.width*3, 0) animated:YES];
        [self setFontColorNumber:3];
        [self refreshData3];
    }else{
        [bottomScrollView setContentOffset:CGPointMake(self.view.bounds.size.width*4, 0) animated:YES];
        [self setFontColorNumber:4];
        [self refreshData4];
    }
}

//btn字体变色
-(void)setFontColorNumber:(int)FontNum{
    if (FontNum == 0) {
        [titlebtn0 setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [titlebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if (FontNum ==1){
        [titlebtn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn1 setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [titlebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if (FontNum ==2){
        [titlebtn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn2 setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [titlebtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if (FontNum ==3){
        [titlebtn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn3 setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
        [titlebtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [titlebtn0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titlebtn4 setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    }
}

//菊花
-(void)loadAnimation{
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.center = self.view.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
}
@end
