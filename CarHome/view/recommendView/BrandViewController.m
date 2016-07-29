//
//  BrandViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BrandViewController.h"
#import "AppService.h"
#import "BulletinChooseVO.h"
#import "BulletinChooseListVO.h"
@interface BrandViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray * array;
    UITableView * _tableView;
    UIActivityIndicatorView *_indicator;
}

@end

@implementation BrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
    [self loadAnimation];
    
    
}
-(void)configUI{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2, 60, self.view.bounds.size.width*0.8, self.view.bounds.size.height-60) style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc]init];
    _tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2, 0, self.view.bounds.size.width*0.8, 60)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.2, self.view.bounds.size.height)];
    view1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:view1];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width*0.2,0 , self.view.bounds.size.width*0.4, 60)];
    label.text = @"选择品牌";
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    UIButton *bulletinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bulletinButton setTitle:@"关闭" forState:UIControlStateNormal];
    bulletinButton.frame = CGRectMake(self.view.bounds.size.width*0.6, 0,self.view.bounds.size.width*0.2, 60);
    [view addSubview:bulletinButton];
    [bulletinButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    bulletinButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [bulletinButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadData{
    [[[AppService alloc]init]getBulletinChooseHandle:^(id result) {
        array =result;
        [_tableView reloadData];
        if (array.count) {
            [_indicator stopAnimating];
            _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([array[0]count]>0) {
        return [array[0] count] +1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([array[1]count]>0) {
        if (section == 0) {
            return 1;
        }else{
            return [array[1][section-1] count];
        }
    }
    return 0;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([array[0]count]>0) {
        if (section == 0) {
            return nil;
        }else{
            return [array[0][section-1] letter];
        }
        
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; 
    if ([array[1]count]>0) {
        if (indexPath.section ==0) {
            cell.textLabel.text = @"全部品牌";
            return cell;
        }else{
            BulletinChooseListVO * model = array[1][indexPath.section-1][indexPath.row];
            cell.textLabel.text = model.name;
            return cell;
        }
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int returnNum = 0;
    NSString * str = @"全部品牌";
    if (indexPath.section>0) {
        BulletinChooseListVO * model = array[1] [indexPath.section-1][indexPath.row];
        returnNum = model.appId.intValue;
        str = model.name;
    }
    [self.brandDelegate
     reciveBrandData:returnNum string: str];
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

@end
