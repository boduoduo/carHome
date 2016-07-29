//
//  HeadView.m
//  TouristGuide
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeadView.h"
#define WIDTH_PERCENT 0.2*self.bounds.size.height
@interface HeadView()
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *label;
@end
@implementation HeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}
-(void)configUI{
    self.backgroundColor =[UIColor whiteColor];
    //设置三角形的图标
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.bounds.size.height*0.3,WIDTH_PERCENT , WIDTH_PERCENT)];
    _icon.image = [UIImage imageNamed:@"arrow_right_pressed"];
    [self addSubview:_icon];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 200, 30)];
    [self addSubview:_label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.tag = 1000;
    btn.frame = self.bounds;
    //[btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
-(void)layoutSubviews
{
    //NSLog(@"%s",__FUNCTION__);
    UIButton *btn = (id)[self viewWithTag:1000];
    btn.frame = self.bounds;
    //NSLog(@"%@",NSStringFromCGRect(self.bounds));
}

-(void)btnClicked:(UIButton *)sender
{
    int temp = self.openRow();
    
    if(temp == 1)
    {
        [UIView animateWithDuration:0.3 animations:^{
            _icon.transform = CGAffineTransformMakeRotation(M_PI_2);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _icon.transform = CGAffineTransformMakeRotation(0);
        }];
    }
}

//-(void)layoutSubviews
//{
//    //NSLog(@"%s",__FUNCTION__);
//    UIButton *btn = (id)[self viewWithTag:1000];
//    btn.frame = self.bounds;
//    //NSLog(@"%@",NSStringFromCGRect(self.bounds));
//}


-(void)setHeadTitle:(NSString *)title
{
    _label.text = title;
}

@end
