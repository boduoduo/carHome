//
//  CarDiscussDetailModel.m
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarDiscussDetailModel.h"

@implementation CarDiscussDetailModel
-(instancetype)initWithDictionay:(NSDictionary *)dic{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"没有找到该key－－%@",key);
}

@end
