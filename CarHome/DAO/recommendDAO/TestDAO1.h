//
//  TestDAO1.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
@class TestVO;
@interface TestDAO1 : NSObject
-(void)save:(TestVO *)vo;
-(NSArray *)findAll;
-(void)dele:(TestVO *)vo;
@end
