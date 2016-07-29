//
//  BulletinChooseListVO.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BulletinChooseListVO : NSObject
@property(nonatomic,copy) NSString * tmimg;
@property(nonatomic,strong) NSNumber * appId;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * imgurl;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
