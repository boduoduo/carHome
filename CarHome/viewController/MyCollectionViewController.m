//
//  MyCollectionViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "CollectionViewController.h"
#import "HistoryViewController.h"
#import "UMSocial.h"
#import "SDImageCache.h"
@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate>{
    __weak IBOutlet UITableView *MyTableView;
    
}

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    }


-(void)configUI{
    MyTableView.delegate =self;
    MyTableView.dataSource = self;
    MyTableView.tableFooterView = [[UITableView alloc]init];
    //关闭tableview的移动，tableview本质上是scrollView
    // MyTableView.userInteractionEnabled = NO;
}

//代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 4;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * MyCollectionID = @"MyCollectionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyCollectionID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyCollectionID];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"icon_me_star"];
            cell.textLabel.text = @"我的收藏";
        }else if(indexPath.row == 1) {
            cell.imageView.image = [UIImage imageNamed:@"icon_me_history"];
            cell.textLabel.text = @"浏览历史";
        }else if(indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"icon_share"];
            cell.textLabel.text = @"分享";
        }else{
            cell.imageView.image = [UIImage imageNamed:@"icon_me_setting"];
            cell.textLabel.text = @"清除缓存";
        }
    }else{
        if (indexPath.row ==0) {
            cell.imageView.image = [UIImage imageNamed:@"icon_my_friend"];
            cell.textLabel.text = @"关于我们";
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            CollectionViewController * CVC = [[CollectionViewController alloc]init];
            [self presentViewController:CVC animated:YES completion:nil];
        }else if(indexPath.row == 1) {
            HistoryViewController * HVC = [[HistoryViewController alloc]init];
            [self presentViewController:HVC animated:YES completion:nil];
        }else if(indexPath.row == 2){
            [self collentClick];
        }else{
            [self clearStorage];
        }
    }
    
}

-(void)collentClick{
    [UMSocialData defaultData].extConfig.qqData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.qqData.url = @"https://itunes.apple.com/cn/app/id1047667835";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"https://itunes.apple.com/cn/app/id1047667835";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://itunes.apple.com/cn/app/id1047667835";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"https://itunes.apple.com/cn/app/id1047667835";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"1052560318"
                                      shareText:@"爱车，爱生活"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline,UMShareToSina,nil]
                                       delegate:self];

}

/***** 清理缓存 ****/
- (void)clearStorage {
    double sdSize = ([[SDImageCache sharedImageCache] getSize])/1024.0/1024.0;
    UIAlertView *alertview = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"共有缓存(%.2lfM),确认清除？", sdSize] message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDisk];
    }else{
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
