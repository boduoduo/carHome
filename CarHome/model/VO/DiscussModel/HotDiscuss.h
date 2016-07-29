//
//  HotDiscuss.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotDiscuss : NSObject
@property(nonatomic,copy) NSString * postusername;
@property(nonatomic,strong) NSNumber * replycounts;
@property(nonatomic,copy) NSString * bbsname;
@property(nonatomic,copy) NSString * lastreplydate;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,strong) NSNumber * bbsid;
@property(nonatomic,copy) NSString * postdate;
@property(nonatomic,strong) NSNumber * ispictopic;
@property(nonatomic,strong) NSNumber * topicid;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
