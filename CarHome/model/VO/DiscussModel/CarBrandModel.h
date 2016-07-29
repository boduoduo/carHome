//
//  CarBrandModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarBrandModel : NSObject
@property(nonatomic,copy)NSString * letter;
@property(nonatomic,copy)NSArray * list;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
