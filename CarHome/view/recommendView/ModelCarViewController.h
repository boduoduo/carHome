//
//  ModelCarViewController.h
//  CarHome
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModelCarDelegate<NSObject>
-(void)reciveModelCarData:(int)data string:(NSString *)str;
@end
@interface ModelCarViewController : UIViewController
@property(nonatomic,assign)id<ModelCarDelegate>modelCarDelegate;
@end
