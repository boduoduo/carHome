//
//  DealerModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealerModel : NSObject
@property(nonatomic,copy) NSString * specprice;
@property(nonatomic,copy) NSString * orderrange;
@property(nonatomic,copy) NSString * shortname;
@property(nonatomic,strong) NSNumber * isauth;
@property(nonatomic,copy) NSString * lon;
@property(nonatomic,strong) NSNumber * ispromotion;
@property(nonatomic,copy) NSString * major;
@property(nonatomic,copy) NSString * city;
@property(nonatomic,copy) NSString * loworminprice;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,strong) NSNumber * is24hour;
@property(nonatomic,copy) NSString * seriesprice;
@property(nonatomic,strong) NSNumber * dealId;  //id
@property(nonatomic,copy) NSString * phonestyled;
@property(nonatomic,copy) NSString * teltext;
@property(nonatomic,strong) NSNumber * ishavelowprice;
@property(nonatomic,copy) NSString * phone;
@property(nonatomic,strong) NSNumber * is400;
@property(nonatomic,copy) NSString * lat;
@property(nonatomic,copy) NSString * price;
@property(nonatomic,strong) NSNumber * scopestatus;
@property(nonatomic,copy) NSString * address;
@property(nonatomic,copy) NSString * scopename;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
