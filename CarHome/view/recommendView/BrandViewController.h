//
//  BrandViewController.h
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BrandDelegate<NSObject>
-(void)reciveBrandData:(int)data string:(NSString *)str;
@end
@interface BrandViewController : UIViewController
@property(nonatomic,assign)id<BrandDelegate>brandDelegate;
@end
