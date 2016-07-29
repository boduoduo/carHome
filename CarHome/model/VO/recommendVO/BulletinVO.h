//
//  BulletinVO.h
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BulletinVO : NSObject
@property(nonatomic,strong) NSNumber * appId;
@property(nonatomic,strong) NSNumber * state;
@property(nonatomic,copy) NSString * appTypename;
@property(nonatomic,copy) NSString * createtime;
@property(nonatomic,copy) NSString * lastid;
@property(nonatomic,copy) NSString * advancetime;
@property(nonatomic,copy) NSString * bgimage;
@property(nonatomic,strong) NSNumber * reviewcount;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * img;
@property(nonatomic,copy) NSString * publishtiptime;
@property(nonatomic,strong) NSNumber * appTypeid;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
