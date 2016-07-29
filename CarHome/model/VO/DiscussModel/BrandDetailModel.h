//
//  BrandDetailModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandDetailModel : NSObject
@property(nonatomic,strong) NSNumber * BrandId;
@property(nonatomic,copy) NSString * name;
@property(nonatomic,copy) NSString * imgurl;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
