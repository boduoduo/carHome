//
//  CarDiscuss.h
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarDiscuss : NSObject
@property(nonatomic,strong)NSString * brandimg;
@property(nonatomic,strong)NSArray * seriesclub;
@property(nonatomic,strong)NSString * brandname;
@property(nonatomic,strong)NSString * letter;
-(instancetype)initWithDictionay:(NSDictionary *)dic;
@end
