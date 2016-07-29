//
//  WebDAO.h
//  CarHome
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
@class WebVO;
@interface WebDAO : NSObject
-(void)save:(WebVO *)vo;
-(void)dele:(WebVO *)vo;
-(NSArray *)findAll;
@end
