//
//  NewNew1DAO1.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewNew1DAO1.h"
#import "LKDBHelper.h"
#import "NewNew1VO.h"
@implementation NewNew1DAO1
-(void)save:(NewNew1VO *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [NewNew1VO searchWithWhere:nil];
}

-(void)dele:(NewNew1VO *)vo{
    [vo deleteToDB];
}
@end
