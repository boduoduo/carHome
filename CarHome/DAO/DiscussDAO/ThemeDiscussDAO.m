//
//  ThemeDiscussDAO.m
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ThemeDiscussDAO.h"
#import "LKDBHelper.h"
#import "ThemeDiscussModel.h"

@implementation ThemeDiscussDAO
-(void)save:(ThemeDiscussModel *)vo{
    [vo saveToDB];
}

-(NSArray *)findAll{
    return [ThemeDiscussModel searchWithWhere:nil];
}

-(void)dele:(ThemeDiscussModel *)vo{
    [vo deleteToDB];
}

@end
