//
//  videoVO.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface videoVO : NSObject
@property(nonatomic,strong) NSNumber * appId;
@property(nonatomic,copy) NSString * lastid;
@property(nonatomic,copy) NSString * smallimg;
@property(nonatomic,copy) NSString * videoaddress;
@property(nonatomic,strong) NSNumber * replycount;
@property(nonatomic,copy) NSString * time;
@property(nonatomic,strong) NSNumber * playcount;
@property(nonatomic,copy) NSString * type;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * updatetime;
@property(nonatomic,copy) NSString * shareaddress;
@property(nonatomic,copy) NSString * indexdetail;
@property(nonatomic,copy) NSString * nickname;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
