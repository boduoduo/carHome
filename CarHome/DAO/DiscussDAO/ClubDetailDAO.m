//
//  ClubDetailDAO.m
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ClubDetailDAO.h"
#import "LKDBHelper.h"
#import "ClubDetailVO.h"
@implementation ClubDetailDAO
-(void)save:(ClubDetailVO *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [ClubDetailVO searchWithWhere:nil];
}

-(void)dele:(ClubDetailVO *)vo{
    [vo deleteToDB];
}
@end
