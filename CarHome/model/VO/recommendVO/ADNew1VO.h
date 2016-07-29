//
//  ADNew1VO.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADNew1VO : NSObject
@property(nonatomic,copy) NSString * imgurl;
@property(nonatomic,copy) NSString * jumpurl;
@property(nonatomic,copy) NSString * updatetime;
@property(nonatomic,strong) NSNumber * appId;
@property(nonatomic,strong) NSNumber * replycount;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,strong) NSNumber * pageindex;
@property(nonatomic,strong) NSNumber * JumpType;
@property(nonatomic,strong) NSNumber * mediatype;
@property(nonatomic,copy) NSString * type;
@property(nonatomic,strong) NSNumber * fromtype;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
