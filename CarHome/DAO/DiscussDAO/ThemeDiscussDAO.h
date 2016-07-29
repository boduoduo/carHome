//
//  ThemeDiscussDAO.h
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ThemeDiscussModel;
@interface ThemeDiscussDAO : NSObject
-(void)save:(ThemeDiscussModel *)vo;
-(NSArray *)findAll;
-(void)dele:(ThemeDiscussModel *)vo;
@end
