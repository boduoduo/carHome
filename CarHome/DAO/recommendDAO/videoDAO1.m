//
//  videoDAO1.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "videoDAO1.h"
#import "videoVO.h"
#import "LKDBHelper.h"
@implementation videoDAO1
-(void)save:(videoVO *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [videoVO searchWithWhere:nil];
}

-(void)dele:(videoVO *)vo{
    [vo deleteToDB];
}
@end
