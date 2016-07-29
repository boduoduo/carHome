//
//  UsualDiscussViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UsualDiscussViewController.h"
#import "UsualDiscussService.h"
#import "CarDiscuss.h"
#import "UIButton+WebCache.h"
#import "ThemeDetailViewController.h"
#import "CarDiscussDetailModel.h"

@interface UsualDiscussViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableOne;
    UITableView * _tableTwo;
    NSArray * _carTypeArray;
    NSArray * _carDiscussArray;
    UIView * _detailView;
    NSMutableArray * _dataList;
    UIActivityIndicatorView * _indicator;
}

@end

@implementation UsualDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self configUI];
    [self loadAnimation];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadAnimation{
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.frame = CGRectMake(SCREEN_WIDTH*0.6,SCREEN_HEIGHT*0.5, 0, 0);
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
    _tableOne.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)loadData{
    [[UsualDiscussService new]getCarTypeWithBlock:^(id data) {
        _carTypeArray = data;
        if(_carTypeArray.count>0){
            [_indicator stopAnimating];
            _tableOne.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        [self loadMyData:_carTypeArray];
        [_tableOne reloadData];
    } AndParamter:URL_CAR_TYPE];
   
    
}

-(void)loadMyData:(NSArray *)array{
    NSArray * search = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    _dataList = [NSMutableArray array];
    for(int i=0;i<26;i++){
        NSMutableArray * array1 = [NSMutableArray array];
        for(int j=0;j<array.count;j++){
            CarDiscuss * model = array[j];
            if([model.letter isEqualToString:search[i]]){
                [array1 addObject:model];
            }
        }
        [_dataList addObject:array1];
    }
//    NSLog(@"%@",_dataList);
}

-(void)configUI{
    UITableView * tableOne = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT) style:UITableViewStylePlain];
//    tableOne.sectionIndexBackgroundColor = [UIColor blueColor];
//    tableOne.sectionIndexMinimumDisplayRowCount = 1;
    [self.view addSubview:tableOne];
    _tableOne = tableOne;
    _tableOne.delegate = self;
    _tableOne.dataSource = self;
    UIView * headViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, 40)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 20,80 , 20)];
    [headViewOne addSubview:titleLabel];
    titleLabel.text = @"车系论坛";
    _tableOne.tableHeaderView = headViewOne;
    
   UITableView * tableTwo = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    _tableTwo.backgroundColor = [UIColor redColor];
    [self.view addSubview:tableTwo];
    _tableTwo = tableTwo;
    _tableTwo.delegate = self;
    _tableTwo.dataSource = self;
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tableTwoBackSwipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_tableTwo addGestureRecognizer:swipe];
    
    UIView * headViewTwo = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, 40)];
    UIButton * TableTwobackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    TableTwobackBtn.frame = CGRectMake(10, 20, 20, 20);
    [TableTwobackBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_icon_returntext_a"] forState:UIControlStateNormal];
    [TableTwobackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [TableTwobackBtn addTarget:self action:@selector(TableTwobackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headViewTwo addSubview:TableTwobackBtn];
    _tableTwo.tableHeaderView = headViewTwo;
    
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 40, SCREEN_WIDTH*0.15,40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_icon_previous"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

#pragma mark -- tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == _tableOne){
        if(_dataList.count>0){
            NSArray * array = _dataList[section];
            return array.count;
        }
        
    }else{
        return _carDiscussArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _tableOne){
        return _dataList.count;
    }else{
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * carTypeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!carTypeCell){
        carTypeCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    for(UIView * view in carTypeCell.contentView.subviews){
        if([view isKindOfClass:[UIButton class]] || [view isKindOfClass:[UILabel class]]){
            [view removeFromSuperview];
        }
    }
    if(tableView == _tableOne){
        NSArray * array = _dataList[indexPath.section];
        CarDiscuss * model = array[indexPath.row];
        UIButton * iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        iconBtn.frame = CGRectMake(15, 4, 36, 36);
        [iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.brandimg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"forum_icon_pic"]];
        [carTypeCell.contentView addSubview:iconBtn];
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 150, 20)];
        nameLabel.text = model.brandname;
        [carTypeCell.contentView addSubview:nameLabel];
    }
    else{
        NSDictionary * dic = _carDiscussArray[indexPath.row];
        carTypeCell.textLabel.text = dic[@"bbsname"];
    }
   
    return carTypeCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     NSArray * search = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    if(tableView == _tableOne){
        return search[section];
    }
    return nil;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray * search = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    return search;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableOne){
        NSArray * array = _dataList[indexPath.section];
        CarDiscuss * model = array[indexPath.row];
        _carDiscussArray = model.seriesclub;
//        [_tableTwo bringSubviewToFront:_tableOne];
        [UIView animateWithDuration:0.3 animations:^{
            _tableTwo.frame = _tableOne.frame;
            [_tableTwo reloadData];
        } completion:^(BOOL finished) {
            
        }];
        NSLog(@"%@",_carDiscussArray);
    }else{
        ThemeDetailViewController * TDVC = [[ThemeDetailViewController alloc]init];
        TDVC.kindDiscuss = URL_CAR_FIX_PARA;
        TDVC.baseURL = URL_BASE_CAR;
        NSDictionary * dic = _carDiscussArray[indexPath.row];
        CarDiscussDetailModel * model = [[CarDiscussDetailModel new]initWithDictionay:dic];
        NSLog(@"%@",model.bbsid);
        TDVC.detailModel = model;
        [self presentViewController:TDVC animated:YES completion:nil];
    }
   
}

#pragma mark --点击事件按钮
-(void)backBtnClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)TableTwobackBtnClicked:(UIButton *)sender{
    [UIView animateWithDuration:0.3 animations:^{
        _tableTwo.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT);
        [_tableOne reloadData];
    }];
}

-(void)tableTwoBackSwipe:(UIGestureRecognizer *)swipe{
    [self TableTwobackBtnClicked:nil];
}

@end
