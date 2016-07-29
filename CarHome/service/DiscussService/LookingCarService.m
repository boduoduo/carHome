//
//  LookingCarService.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LookingCarService.h"
#import "AFHTTPRequestOperationManager.h"
#import "CarBrandModel.h"
#import "CarTypeModel.h"
#import "CutPriceModel.h"

@implementation LookingCarService

-(void)getLookingCarWithBlock:(ServiceBlock)myBlock{
    NSString * path = [NSString stringWithFormat:@"%@",URL_LOOKING_CAR];
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject[@"result"]){
            NSDictionary * resultDic = responseObject[@"result"];
            if(resultDic[@"brandlist"]){
                NSArray * brandListArray = resultDic[@"brandlist"];
                NSMutableArray * resultArray = [NSMutableArray array];
                for(NSDictionary * dic in brandListArray){
                    CarBrandModel * model = [[CarBrandModel new]initWithDictionary:dic];
                    [resultArray addObject:model];
                }
                myBlock(resultArray);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getCarDetailWithID:(NSString *)carId andBlock:(ServiceBlock)myBlock{
    NSString * path = [NSString stringWithFormat:@"%@%@%@",URL_CARTYPE_DETAIL,carId,DETAIL_PARA];
//    NSLog(@"%@",path);
    //添加text/plain类型的网络数据，不然解析不出来
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject[@"result"]){
            NSDictionary * resultDic = responseObject[@"result"];
            if(resultDic[@"fctlist"]){
                NSMutableArray * resultArray = [NSMutableArray array];
                NSArray * fctlistArray = resultDic[@"fctlist"];
                for(NSDictionary * dic in fctlistArray){
                    CarTypeModel * model = [[CarTypeModel new]initWithDictionary:dic];
                    [resultArray addObject:model];
                }
                myBlock(resultArray);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error);
    }];
}

-(void)getCutPriceWithPage:(int)page andBlock:(ServiceBlock)myBlock{
    NSString * path = [NSString stringWithFormat:@"%@%d%@",URL_CUT_PRICE,page,CUT_PRICE_PARA];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject[@"result"]){
            NSDictionary * resultDic = responseObject[@"result"];
            if(resultDic[@"carlist"]){
                NSArray * carlistArray = resultDic[@"carlist"];
                NSMutableArray * resultArray = [NSMutableArray array];
                for(NSDictionary * dic in carlistArray){
                    CutPriceModel * model = [[CutPriceModel new]initWithDictionary:dic];
                    [resultArray addObject:model];
                }
                myBlock(resultArray);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
