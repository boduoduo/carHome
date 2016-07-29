//
//  CarTypeModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarTypeModel : NSObject
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSArray * serieslist;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
