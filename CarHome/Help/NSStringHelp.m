//
//  NSStringHelp.m
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSStringHelp.h"

@implementation NSStringHelp
-(NSMutableArray *)photoString:(NSString *)str{
    NSMutableArray *resultArr = [NSMutableArray array];
    NSArray * arr =[str componentsSeparatedByString:@"http:"];
    
    for (NSString * string in arr) {
        if ([string containsString:@".jpg"]) {
            NSRange range = [string rangeOfString:@".jpg"];
            NSString *str = [string substringToIndex:range.location];
            NSString * resultStr = [NSString stringWithFormat:@"http:%@.jpg",str];
            [resultArr addObject:resultStr];
        }
    }
    return resultArr;
}
@end
