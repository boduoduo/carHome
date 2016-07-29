//
//  HotDiscussDAO.h
//  CarHome
//
//  Created by qianfeng on 15/10/25.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotDiscuss;
@interface HotDiscussDAO : NSObject
-(void)save:(HotDiscuss *)vo;
-(NSArray *)findAll;
-(void)dele:(HotDiscuss *)vo;
@end
