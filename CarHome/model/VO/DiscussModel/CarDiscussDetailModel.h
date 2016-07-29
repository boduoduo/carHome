//
//  CarDiscussDetailModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarDiscussDetailModel : NSObject
@property(nonatomic,strong) NSNumber * bbsid;
@property(nonatomic,copy) NSString * bbsname;
@property(nonatomic,copy) NSString * bbstype;
@property(nonatomic,strong) NSNumber * sort;
-(instancetype)initWithDictionay:(NSDictionary *)dic;
@end
