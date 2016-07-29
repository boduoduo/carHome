//
//  ThemeDiscussModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//主题内论坛参数
@interface ThemeDiscussModel : NSObject
@property(nonatomic,strong) NSNumber * isask;
@property(nonatomic,strong) NSNumber * isclosed;
@property(nonatomic,strong) NSNumber * isopuptopic;
@property(nonatomic,copy) NSString * postusername;
@property(nonatomic,strong) NSNumber * topicid;
@property(nonatomic,copy) NSString * bbstype;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * lastreplydate;
@property(nonatomic,strong) NSNumber * ispic;
@property(nonatomic,strong) NSNumber * bbsid;
@property(nonatomic,copy) NSString * bbsname;
@property(nonatomic,copy) NSString * topictype;
@property(nonatomic,strong) NSNumber * isview;
@property(nonatomic,strong) NSNumber * replycounts;
@property(nonatomic,copy) NSString * posttopicdate;
@property(nonatomic,strong) NSNumber * isresolve;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
