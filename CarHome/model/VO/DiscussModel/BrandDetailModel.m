//
//  BrandDetailModel.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BrandDetailModel.h"

@implementation BrandDetailModel
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if(self = [super init]){
//        [self setValuesForKeysWithDictionary:dic];
        self.imgurl = dic[@"imgurl"];
        self.name = dic[@"name"];
        self.BrandId = dic[@"id"];
    }
    return self;
}

-(void)setValue:(id)value forKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _BrandId = value;
    }
}

@end
