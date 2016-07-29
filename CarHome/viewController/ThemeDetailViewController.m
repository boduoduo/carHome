//
//  ThemeDetailViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ThemeDetailViewController.h"
#import "UsualDiscussService.h"
#import "ThemeDetailTableViewCell.h"
#import "ThemeDiscussModel.h"
#import "ClubDetailViewController.h"
#import "MJRefresh.h"
#import "ThemeDiscussDAO.h"


@interface ThemeDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableView;
    NSArray * _dataList;
    UILabel * _titleLabel;
    UIActivityIndicatorView * _indicator;
    int _page;
}

@end

@implementation ThemeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _page = 1;
    [self configUI];
    [self loadAnimation];
    [self loadData];
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAnimation{
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.center = self.view.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)configUI{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20, 60, 40);
    [backBtn setImage:[UIImage imageNamed:@"bar_btn_icon_returntext_a"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:0.1976 green:0.4495 blue:0.9986 alpha:1.0] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    UILabel * titltLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2, 20, 150, 40)];
    titltLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titltLabel];
    _titleLabel = titltLabel;
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    [_tableView registerNib:[UINib nibWithNibName:@"ThemeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThemeDetailCell"];
}

-(void)updateData{
    __block ThemeDetailViewController* blockSelf = self;
    
    // 添加下拉刷新
   _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf loadData];
        
        // 表示N = 5秒之后结束Refreshing
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.header endRefreshing];
        });
    }];
    
    // 添加上拉加载更多
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getNextData];
        
        // 表示N = 5秒之后结束Refreshing
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_tableView.footer endRefreshing];
        });
    }];
}

-(void)getNextData{
    _page++;
    [self loadData];
}

-(void)loadData{
    NSString * str = [NSString string];
    if(_model){
        str = [NSString stringWithFormat:@"%@",_model.bbsid];
        _titleLabel.text = _model.bbsname;
    }else if(_areaModel){
        str = [NSString stringWithFormat:@"%@",_areaModel.bbsid];
        _titleLabel.text = [NSString stringWithFormat:@"%@论坛",_areaModel.bbsname];
    }else{
        str = [NSString stringWithFormat:@"%@",_detailModel.bbsid];
        _titleLabel.text = _detailModel.bbsname;
    }
    [[UsualDiscussService new]getThemeDiscussWithPara:str basePara:_baseURL KindPara:_kindDiscuss andBlock:^(id data) {
        _dataList = data;
        if(_dataList.count>0){
            [_indicator stopAnimating];
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        [_tableView reloadData];
    } andPage:_page];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThemeDetailCell" forIndexPath:indexPath];
    ThemeDiscussModel * model = _dataList[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.timeLabel.text = [NSString stringWithFormat:@"回复:%@", model.lastreplydate];
    cell.replyLabel.text = [NSString stringWithFormat:@"%@ %@回",model.postusername,model.replycounts];
    if(model.ispic.intValue){
        cell.picImageView.image = [UIImage imageNamed:@"forum_icon_pic"];
        
    }
    if([model.topictype isEqualToString:@"精"]){
        cell.jingImageView.image = [UIImage imageNamed:@"forum_icon_fine"];
    }else if ([model.topictype isEqualToString:@"顶"]){
        cell.jingImageView.image = [UIImage imageNamed:@"forum_icon_top"];
    }else if ([model.topictype isEqualToString:@"问"]){
        cell.jingImageView.image = [UIImage imageNamed:@"forum_icon_question_ed"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeDiscussModel * model = _dataList[indexPath.row];
    [[ThemeDiscussDAO new]save:model];
    ClubDetailViewController * CDVC = [[ClubDetailViewController alloc]init];
    CDVC.bbsid = [NSString stringWithFormat:@"%@",model.bbsid];
    CDVC.topcid = [NSString stringWithFormat:@"%@",model.topicid];
    CDVC.module = @"three";
    CDVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:CDVC animated:YES completion:nil];
    
}

-(void)backBtnClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
