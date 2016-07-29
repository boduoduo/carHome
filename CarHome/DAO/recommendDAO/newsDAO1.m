//
//  newsDAO1.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "newsDAO1.h"
#import "NewsVO.h"
#import "LKDBHelper.h"
@implementation newsDAO1
-(void)save:(NewsVO *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [NewsVO searchWithWhere:nil];
}

-(void)dele:(NewsVO *)vo{
    [vo deleteToDB];
}

@end
