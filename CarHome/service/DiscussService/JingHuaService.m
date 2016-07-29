//
//  JingHuaService.m
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "JingHuaService.h"
#import "AFHTTPRequestOperationManager.h"
#import "CarHomeModel.h"
#import "HotDiscuss.h"

@implementation JingHuaService
-(void)getCarHomeWithBlock:(SerViceBlock)block paramter:(NSString *)paramter{
    NSString * path = [NSString stringWithFormat:@"%@%@%@",URL_JINGHUA,paramter,FiX_PARA];
//    NSLog(@"%@",path);
        [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * resultArr = [NSMutableArray array];
            if(responseObject[@"result"]){
                NSDictionary * listDic = responseObject[@"result"];
                NSArray * listArray = listDic[@"list"];
                for (NSDictionary * dic in listArray) {
                    CarHomeModel * model = [[CarHomeModel alloc]initWithDictionary:dic];
                    [resultArr addObject:model];
                }
                block(resultArr);
            }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getCarHomeWithPage:(int)page andBlock:(SerViceBlock)myBlock paramter:(NSString *)paramter{
    NSString * path = [NSString stringWithFormat:@"%@%@-p%d%@",URL_JINGHUA,paramter,page,UPDATE_FIX_PARA];
    //    NSLog(@"%@",path);
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * resultArr = [NSMutableArray array];
        if(responseObject[@"result"]){
            NSDictionary * listDic = responseObject[@"result"];
            NSArray * listArray = listDic[@"list"];
            for (NSDictionary * dic in listArray) {
                CarHomeModel * model = [[CarHomeModel alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            myBlock(resultArr);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void)getHotDiscussWithBlock:(SerViceBlock)myblock{
    NSString * path = [NSString stringWithFormat:@"%@%@",URL_DISCUSS,HOT_PARA];
//    NSLog(@"%@",path);
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * resultArr = [NSMutableArray array];
        if(responseObject[@"result"]){
            NSDictionary * listDic = responseObject[@"result"];
            NSArray * listArray = listDic[@"list"];
            for (NSDictionary * dic in listArray) {
                HotDiscuss * model = [[HotDiscuss alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            myblock(resultArr);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
