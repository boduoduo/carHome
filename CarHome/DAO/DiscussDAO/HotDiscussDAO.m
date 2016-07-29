//
//  HotDiscussDAO.m
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotDiscussDAO.h"
#import "LKDBHelper.h"
#import "HotDiscuss.h"
@implementation HotDiscussDAO
-(void)save:(HotDiscuss *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [HotDiscuss searchWithWhere:nil];
}

-(void)dele:(HotDiscuss *)vo{
    [vo deleteToDB];
}
@end
