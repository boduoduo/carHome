//
//  NewNew1DAO1.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
@class NewNew1VO;
@interface NewNew1DAO1 : BaseDAO
-(void)save:(NewNew1VO *)vo;
-(NSArray *)findAll;
-(void)dele:(NewNew1VO *)vo;
@end
