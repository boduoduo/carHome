//
//  WebDAO.m
//  CarHome
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "WebDAO.h"
#import "WebVO.h"
#import "LKDBHelper.h"
@implementation WebDAO
-(void)save:(WebVO *)vo{
    [vo saveToDB];
}
-(void)dele:(WebVO *)vo{
  [vo deleteToDB];
}
-(NSArray *)findAll{
    return [WebVO searchWithWhere:nil];
}
@end
