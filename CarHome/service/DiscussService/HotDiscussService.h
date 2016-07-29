//
//  HotDiscussService.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SerViceBlock)(id data);
@interface HotDiscussService : NSObject
-(void)getHotDiscussWithPage:(int)page andBlock:(SerViceBlock)myBlock;
@end
