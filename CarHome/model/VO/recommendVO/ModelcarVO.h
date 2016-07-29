//
//  ModelcarVO.h
//  CarHome
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelcarVO : NSObject
@property(nonatomic,strong) NSNumber * levelid;
@property(nonatomic,copy) NSString * levelname;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
