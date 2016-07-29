//
//  ThemeViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeModel.h"
#import "UsualDiscussService.h"
#import "ThemeDetailViewController.h"

@interface ThemeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView * _tableView;
    NSMutableArray * _dataList;
    UIActivityIndicatorView * _indicator;
}

@end

@implementation ThemeViewController

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
        _dataList = data;
        if(_dataList.count > 0){
            [_indicator stopAnimating];
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
        [_tableView reloadData];
    } AndParamter:URL_THEME];
}


-(void)configUI{
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 40, SCREEN_WIDTH*0.15,40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_icon_previous"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.2, 0, SCREEN_WIDTH*0.8, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.delegate =self;
    _tableView.dataSource = self;
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, 60)];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH*0.8-100)/2, 20, 100,30)];
    titleLabel.text = @"主题论坛";
    [headView addSubview:titleLabel];
    _tableView.tableHeaderView = headView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    ThemeModel * model = _dataList[indexPath.row];
    cell.textLabel.text = model.bbsname;
    NSLog(@"--%@ -- %@ ",model.bbsid,model.bbstype);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThemeModel * mo = _dataList[indexPath.row];
    ThemeDetailViewController * TDVC = [[ThemeDetailViewController alloc]init];
    TDVC.model = mo;
    TDVC.kindDiscuss = URL_THEME_FIX_PARA;
    TDVC.baseURL = URL_BASE_THEME;
    TDVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:TDVC animated:YES completion:nil];
}

-(void)backBtnClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
