//
//  DealerModel.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DealerModel.h"

@implementation DealerModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
//        [self setValuesForKeysWithDictionary:dic];
        _orderrange = dic[@"orderrange"];
        _city = dic[@"city"];
        _name = dic[@"name"];
        _is400 = dic[@"is400"];
        _phone = dic[@"phone"];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _dealId = value;
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有找到该Key－－－%@",key);
}
@end
