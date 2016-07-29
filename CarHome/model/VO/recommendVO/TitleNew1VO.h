//
//  TitleNew1VO.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleNew1VO : NSObject
@property(nonatomic,strong) NSNumber * appId;
@property(nonatomic,copy) NSString * smallpic;
@property(nonatomic,strong) NSNumber * replycount;
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
