//
//  TestVO.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestVO : NSObject
@property(nonatomic,strong) NSNumber * appId;
@property(nonatomic,strong) NSNumber * newstype;
@property(nonatomic,copy) NSString * smallpic;
@property(nonatomic,strong) NSNumber * dbid;
@property(nonatomic,strong) NSNumber * replycount;
@property(nonatomic,copy) NSString * intacttime;
@property(nonatomic,copy) NSString * lasttime;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,strong) NSNumber * mediatype;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * updatetime;
@property(nonatomic,strong) NSNumber * jumppage;
@property(nonatomic,copy) NSString * indexdetail;
@property(nonatomic,strong) NSNumber * pagecount;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
