//
//  CarPriceModel.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarPriceModel.h"

@implementation CarPriceModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
//        [self setValuesForKeysWithDictionary:dic];
        _price = dic[@"price"];
        _name = dic[@"name"];
        _levelname = dic[@"levelname"];
        _imgurl = dic[@"imgurl"];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _priceId = value;
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有找到该Key－－－%@",key);
}
@end
