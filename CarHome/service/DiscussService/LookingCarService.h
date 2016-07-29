//
//  LookingCarService.h
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  void (^ServiceBlock) (id data);

//车品牌及型号接口
#define URL_LOOKING_CAR @"http://baojiac.qichecdn.com/v3.5.5/cars/brands-a2-pm1-v3.5.5-ts0.html"
#define URL_CARTYPE_DETAIL @"http://app.api.autohome.com.cn/autov3.2/cars/seriesprice-a2-pm1-v3.2.0-b"
#define DETAIL_PARA @"-t1.html"

//降价接口
#define URL_CUT_PRICE @"http://app.api.autohome.com.cn/autov3.2/dealer/pdspecs-a2-pm1-v3.2.0-pi440000-c440300-o0-b0-ss0-sp0-p"
#define CUT_PRICE_PARA @"-s20.html"

@interface LookingCarService : NSObject
-(void)getLookingCarWithBlock:(ServiceBlock)myBlock;
-(void)getCarDetailWithID:(NSString *)carId andBlock:(ServiceBlock)myBlock;
-(void)getCutPriceWithPage:(int)page andBlock:(ServiceBlock)myBlock;

@end
