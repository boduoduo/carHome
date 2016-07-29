//
//  CutPriceModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CutPriceModel : NSObject
@property(nonatomic,strong)NSDictionary * dealer;
@property(nonatomic,copy) NSString * specstatus;
@property(nonatomic,copy) NSString * fctprice;
@property(nonatomic,copy) NSString * enddate;
@property(nonatomic,copy) NSString * assellphone;
@property(nonatomic,copy) NSString * seriesname;
@property(nonatomic,copy) NSString * orderrange;
@property(nonatomic,copy) NSString * orderrangetitle;
@property(nonatomic,strong) NSNumber * seriesid;
@property(nonatomic,strong) NSNumber * articleid;
@property(nonatomic,copy) NSString * specname;
@property(nonatomic,copy) NSString * specpic;
@property(nonatomic,strong) NSNumber * specid;
@property(nonatomic,strong) NSNumber * inventorystate;
@property(nonatomic,copy) NSString * styledinventorystate;
@property(nonatomic,strong) NSNumber * articletype;
@property(nonatomic,copy) NSString * dealerprice;
@property(nonatomic,strong) NSNumber * ordercount;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
