//
//  AppService.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIImage;
typedef void(^AppServiceHandle) (id result);
@interface AppService : NSObject
-(void)getRecommendAppByNum:(int)num handle:(AppServiceHandle)handle;
-(void)getRecommend1AppByNum:(int)num b:(int)b levelid:(int)levelid handle:(AppServiceHandle)handle;
-(void)getRecommend2AppByNum:(int)num vt:(int)vt handle:(AppServiceHandle)handle;
-(void)getRecommend3AppByNum:(int)num handle:(AppServiceHandle)handle;
-(void)getRecommend4AppByNum:(int)num handle:(AppServiceHandle)handle;
-(void)getBulletinChooseHandle:(AppServiceHandle)handle;
-(void)getModelCarHandle:(AppServiceHandle)handel;
-(UIImage*)getImage:(NSString *)str;
@end
