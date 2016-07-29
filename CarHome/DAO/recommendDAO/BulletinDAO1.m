//
//  BulletinDAO1.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BulletinDAO1.h"
#import "BulletinVO.h"
#import "LKDBHelper.h"
@implementation BulletinDAO1
-(void)save:(BulletinVO *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [BulletinVO searchWithWhere:nil];
}

-(void)dele:(BulletinVO *)vo{
    [vo deleteToDB];
}
@end
