//
//  CarHomeDAO.m
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CarHomeDAO.h"
#import "LKDBHelper.h"
#import "CarHomeModel.h"
@implementation CarHomeDAO
-(void)save:(CarHomeModel *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [CarHomeModel searchWithWhere:nil];
}

-(void)dele:(CarHomeModel *)vo{
    [vo deleteToDB];
}
@end
