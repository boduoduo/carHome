//
//  ThemeDetailViewController.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"
#import "AreaModel.h"
#import "CarDiscuss.h"
#import "CarDiscussDetailModel.h"

@interface ThemeDetailViewController : UIViewController
@property(nonatomic,retain)ThemeModel * model;
@property(nonatomic,retain)AreaModel * areaModel;
@property(nonatomic,retain)CarDiscuss * carModel;
@property(nonatomic,retain)CarDiscussDetailModel * detailModel;
@property(nonatomic,copy)NSString * baseURL;
@property(nonatomic,copy)NSString * kindDiscuss;

@end
