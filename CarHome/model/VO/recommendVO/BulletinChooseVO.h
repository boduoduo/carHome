//
//  BulletinChooseVO.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BulletinChooseVO : NSObject
@property(nonatomic,copy) NSString * letter;
@property(nonatomic,copy) NSArray * list;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
