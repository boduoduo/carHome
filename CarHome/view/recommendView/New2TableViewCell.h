//
//  New2TableViewCell.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface New2TableViewCell : UITableViewCell
@property(nonatomic ,strong)IBOutlet UIImageView * iconImage1;
@property(nonatomic ,strong)IBOutlet UIImageView * iconImage2;
@property(nonatomic ,strong)IBOutlet UIImageView * iconImage3;
@property(nonatomic ,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic ,strong)IBOutlet UILabel *dateLabel;
@property(nonatomic ,strong)IBOutlet UILabel *decriptionLabel;
@end
