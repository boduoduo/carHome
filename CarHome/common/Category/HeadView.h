//
//  HeadView.h
//  TouristGuide
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadView : UIView
@property(nonatomic,copy) int (^openRow)(void);
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setHeadTitle:(NSString *)title;
@end
