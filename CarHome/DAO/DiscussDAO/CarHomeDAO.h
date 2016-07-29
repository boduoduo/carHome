//
//  CarHomeDAO.h
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CarHomeModel;
@interface CarHomeDAO : NSObject
-(void)save:(CarHomeModel *)vo;
-(NSArray *)findAll;
-(void)dele:(CarHomeModel *)vo;
@end
