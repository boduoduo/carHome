//
//  TestDAO1.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TestDAO1.h"
#import "TestVO.h"
#import "LKDBHelper.h"
@implementation TestDAO1
-(void)save:(TestVO *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [TestVO searchWithWhere:nil];
}

-(void)dele:(TestVO *)vo{
    [vo deleteToDB];
}
@end
