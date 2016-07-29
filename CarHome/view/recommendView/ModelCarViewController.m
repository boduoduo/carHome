//
//  ModelCarViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ModelCarViewController.h"
#import "ModelcarVO.h"
#import "AppService.h"
@interface ModelCarViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray * resultArr;
    UITableView * _tableView;
    UIActivityIndicatorView *_indicator;
}

@end

@implementation ModelCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    resultArr = [NSMutableArray array];
    [self loadData];
    [self configUI];
    [self loadAnimation];
}
-(void)loadData{
   [[[AppService alloc]init]getModelCarHandle:^(id result) {
       resultArr = result;
       [_tableView reloadData];
       if (resultArr.count>0) {
           [_indicator stopAnimating];
           _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
       }
   }];
}

-(void)configUI{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2,  60, self.view.bounds.size.width*0.8, self.view.bounds.size.height- 60) style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc]init];
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
    label.text = @"选择级别";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    UIButton *bulletinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bulletinButton setTitle:@"关闭" forState:UIControlStateNormal];
    bulletinButton.frame = CGRectMake(self.view.bounds.size.width*0.6, 0,self.view.bounds.size.width*0.2,  60);
    [view addSubview:bulletinButton];
    [bulletinButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    bulletinButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bulletinButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark --代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (resultArr.count>0) {
        return resultArr.count;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"carCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    ModelcarVO * model = resultArr[indexPath.row];
    cell.textLabel.text = model.levelname;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelcarVO * model = resultArr[indexPath.row];
    [self.modelCarDelegate reciveModelCarData:model.levelid.intValue string:model.levelname];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)btnClick{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
