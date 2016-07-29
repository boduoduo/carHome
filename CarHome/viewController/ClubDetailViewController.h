//
//  ClubDetailViewController.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define URL_HOTDISCUSS_DETAIL @"http://forum.app.autohome.com.cn/autov4.9.5/forum/club/topiccontent-a2-pm2-v4.9.5-t"
#define HOT_DISCUSS_DEYAIL_PARA @"-s20-c1-nt0-fs1-sp0-al0-cw360.json"

@interface ClubDetailViewController : UIViewController
@property(nonatomic,copy)NSString * bbsid;
@property(nonatomic,copy)NSString * topcid;
@property(nonatomic,copy)NSString * module;
@property(nonatomic,copy)NSString * webPath;
@end
