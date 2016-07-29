//
//  JingHuaService.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SerViceBlock)(id data);
@interface JingHuaService : NSObject
-(void)getCarHomeWithBlock:(SerViceBlock)block paramter:(NSString *)paramter;
-(void)getCarHomeWithPage:(int)page andBlock:(SerViceBlock)myBlock paramter:(NSString *)paramter;
-(void)getHotDiscussWithBlock:(SerViceBlock)myblock;
@end
