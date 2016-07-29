//
//  UsualDiscussService.h
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^ServiceBlock)(id data);

@interface UsualDiscussService : NSObject
-(void)getCarTypeWithBlock:(ServiceBlock)myBlock AndParamter:(NSString *)para;
-(void)getThemeDiscussWithPara:(NSString *)para basePara:(NSString *)basePara KindPara:(NSString *)kindPara andBlock:(ServiceBlock)myBlock andPage:(int)page;
@end
