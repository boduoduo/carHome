//
//  New1TableViewCell.h
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface New1TableViewCell : UITableViewCell
@property(nonatomic ,strong)IBOutlet UIImageView * iconImage;
@property(nonatomic ,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic ,strong)IBOutlet UILabel *dateLabel;
@property(nonatomic ,strong)IBOutlet UILabel *descriptionLabel;
@end
