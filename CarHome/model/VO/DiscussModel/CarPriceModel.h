//
//  CarPriceModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarPriceModel : NSObject
@property(nonatomic,strong) NSNumber * levelid;
@property(nonatomic,strong) NSNumber * priceId;
@property(nonatomic,copy) NSString * levelname;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * imgurl;
@property(nonatomic,copy) NSString * price;
-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
