//
//  videoDAO1.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
@class videoVO;
@interface videoDAO1 : NSObject
-(void)save:(videoVO *)vo;
-(NSArray *)findAll;
-(void)dele:(videoVO *)vo;
@end
