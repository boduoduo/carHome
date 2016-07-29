//
//  CutPriceTableViewCell.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CutPriceTableViewCell.h"

@implementation CutPriceTableViewCell

- (void)awakeFromNib {
    _sellWhereLabel.layer.cornerRadius = 5;
    _sellWhereLabel.layer.masksToBounds = YES;
    
    _callLabel.layer.cornerRadius = 5;
    _callLabel.layer.masksToBounds = YES;
    
    _hourLabel.layer.cornerRadius = 5;
    _hourLabel.layer.masksToBounds = YES;
    
    _askLabel.layer.cornerRadius = 5;
    _askLabel.layer.masksToBounds = YES;
    
    _amoutLabel.layer.cornerRadius = 5;
    _amoutLabel.layer.masksToBounds = YES;
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
