//
//  BulletinVO.m
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BulletinVO.h"

@implementation BulletinVO
-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.appId = value;
    }
    if ([key isEqualToString:@"typename"]) {
        self.appTypename =value;
    }
    if ([key isEqualToString:@"typeid"]) {
        self.appTypeid = value;
    }
}
@end
