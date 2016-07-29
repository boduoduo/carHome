//
//  CarHomeModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarHomeModel : NSObject
@property(nonatomic,copy) NSString * smallpic;
@property(nonatomic,strong) NSNumber * isclosed;
@property(nonatomic,strong) NSNumber * postmemberid;
@property(nonatomic,copy) NSString * imgurl;
@property(nonatomic,copy) NSString * postusername;
@property(nonatomic,strong) NSNumber * topicid;
@property(nonatomic,copy) NSString * bbstype;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * lastreplydate;
@property(nonatomic,copy) NSString * bigpic;
@property(nonatomic,copy) NSString * topictype;
@property(nonatomic,strong) NSNumber * bbsid;
@property(nonatomic,copy) NSString * bbsname;
@property(nonatomic,strong) NSNumber * replycounts;
@property(nonatomic,strong) NSNumber * views;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
