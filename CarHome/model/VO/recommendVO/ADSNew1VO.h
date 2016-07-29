//
//  ADSNew1VO.h
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADSNew1VO : NSObject
@property(nonatomic,strong) NSNumber * appId;
@property(nonatomic,copy) NSString * lastid;
@property(nonatomic,copy) NSString * smallpic;
@property(nonatomic,strong) NSNumber * replycount;
@property(nonatomic,strong) NSNumber * jumptype;
@property(nonatomic,copy) NSString * appname;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,copy) NSString * jumpurl;
@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * updatetime;
@property(nonatomic,copy) NSString * appurlscheme;
@property(nonatomic,copy) NSString * iconurl;
@property(nonatomic,strong) NSNumber * datatype;
@property(nonatomic,copy) NSString * indexdetail;
@property(nonatomic,strong) NSNumber * pagecount;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
