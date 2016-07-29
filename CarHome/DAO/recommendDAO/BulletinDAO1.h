//
//  BulletinDAO1.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"
@class BulletinVO;
@interface BulletinDAO1 : NSObject
-(void)save:(BulletinVO *)vo;
-(NSArray *)findAll;
-(void)dele:(BulletinVO *)vo;
@end
