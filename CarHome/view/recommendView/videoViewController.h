//
//  videoViewController.h
//  CarHome
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol videoDelegate<NSObject>
-(void)reciveVideoData:(int)data string:(NSString *)str;
@end
@interface videoViewController : UIViewController
@property(nonatomic,assign)id<videoDelegate>videoDelegate;
@end
