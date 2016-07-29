//
//  bulletinTableViewCell.h
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bulletinTableViewCell : UITableViewCell
@property (nonatomic,weak)IBOutlet UILabel * stateLabel;
@property (nonatomic,weak)IBOutlet UILabel * typenameLabel;
@property (nonatomic,weak)IBOutlet UILabel * titlelabel;
@property (nonatomic,weak)IBOutlet UILabel * reviewcountLabel;
@property (nonatomic,weak)IBOutlet UIImageView * iconImage;
@property (nonatomic,weak)IBOutlet UILabel * advancetimeLabel;
@end
