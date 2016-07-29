//
//  newsDAO1.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
@class NewsVO;
@interface newsDAO1 : NSObject
-(void)save:(NewsVO *)vo;
-(NSArray *)findAll;
-(void)dele:(NewsVO *)vo;
@end
