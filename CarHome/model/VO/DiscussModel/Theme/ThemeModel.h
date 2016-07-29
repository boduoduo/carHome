//
//  ThemeModel.h
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeModel : NSObject
@property(nonatomic,strong) NSNumber * bbsid;
@property(nonatomic,copy) NSString * bbsname;
@property(nonatomic,copy) NSString * bbstype;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
@end
