//
//  videoViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "videoViewController.h"

@interface videoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    NSArray * resultArr;
    NSArray * numberArr;
}

@end

@implementation videoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    /*
     vt0全部
     vt8原创
     vt9实拍
     vt2试车
     vt4花边
     vt7事件
     vt1新车
     vt3广告
     vt5技术
     */
    resultArr = @[@"全部",@"原创",@"实拍",@"试车",@"花边",@"事件",@"新车",@"广告",@"技术"];
    numberArr = @[@0,@8,@9,@2,@4,@7,@1,@3,@5];
}

-(void)configUI{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2, 60, self.view.bounds.size.width*0.8, self.view.bounds.size.height- 60) style:UITableViewStylePlain];
    _tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2, 0, self.view.bounds.size.width*0.8,  60)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.2, self.view.bounds.size.height)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view1];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2,0 , self.view.bounds.size.width*0.4,  60)];
    label.text = @"视频分类";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    UIButton *bulletinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bulletinButton setTitle:@"关闭" forState:UIControlStateNormal];
    bulletinButton.frame = CGRectMake(self.view.bounds.size.width*0.6, 0,self.view.bounds.size.width*0.2,60);
    [view addSubview:bulletinButton];
    [bulletinButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    bulletinButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bulletinButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellID= @"VideoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    cell.textLabel.text = resultArr[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.videoDelegate reciveVideoData:[numberArr[indexPath.row]intValue] string:resultArr[indexPath.row]];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)btnClick{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
