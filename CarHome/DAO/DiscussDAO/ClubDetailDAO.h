//
//  ClubDetailDAO.h
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClubDetailVO;
@interface ClubDetailDAO : NSObject
-(void)save:(ClubDetailVO *)vo;
-(NSArray *)findAll;
-(void)dele:(ClubDetailVO *)vo;
@end
