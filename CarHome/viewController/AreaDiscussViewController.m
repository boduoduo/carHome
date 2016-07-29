//
//  AreaDiscussViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AreaDiscussViewController.h"
#import "UsualDiscussService.h"
#import "AreaModel.h"
#import "ThemeDetailViewController.h"

@interface AreaDiscussViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableView;
    NSMutableArray * _dataList;
    NSArray * _areaArray;
    NSArray * _searchArray;
    UIActivityIndicatorView * _indicator;
}

@end

@implementation AreaDiscussViewController

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
    indicator.center = _tableView.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)loadData{
    [[UsualDiscussService new]getCarTypeWithBlock:^(id data) {
        _areaArray = data;
        if(_areaArray.count >0){
            [_indicator stopAnimating];
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        [self loadMyData:_areaArray];
        [_tableView reloadData];
    } AndParamter:URL_AREA];
}

-(void)loadMyData:(NSArray *)array{
    NSArray * search = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    _searchArray = search;
    _dataList = [NSMutableArray array];
    for(int i=0;i<26;i++){
        NSMutableArray * array1 = [NSMutableArray array];
        for(int j=0;j<array.count;j++){
             AreaModel* model = array[j];
            if([model.firstletter isEqualToString:search[i]]){
                [array1 addObject:model];
            }
        }
        [_dataList addObject:array1];
    }
//    NSLog(@"%@",_dataList);
}

-(void)configUI{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 40, SCREEN_WIDTH*0.15,40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_icon_previous"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
   UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, 40)];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH*0.8-100)/2, 10, 100,30)];
    titleLabel.text = @"地区论坛";
    [headView addSubview:titleLabel];
    _tableView.tableHeaderView = headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * array = _dataList[section];
    return array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    for(UIView * view in cell.contentView.subviews){
//        if([view isKindOfClass:[UILabel class]]){
//            [view removeFromSuperview];
//        }
//    }
    NSArray * array = _dataList[indexPath.section];
    AreaModel * model = array[indexPath.row];
    cell.textLabel.text = model.bbsname;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _searchArray[section];
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _searchArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray * array = _dataList[indexPath.section];
    AreaModel * mo = array[indexPath.row];
    ThemeDetailViewController * TDVC = [[ThemeDetailViewController alloc]init];
    TDVC.kindDiscuss = URL_AREA_FIX_PARA;
    TDVC.baseURL = URL_BASE_AREA;
    TDVC.areaModel = mo;
    [self presentViewController:TDVC animated:YES completion:nil];
}

-(void)backBtnClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
