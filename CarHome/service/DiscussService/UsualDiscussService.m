//
//  UsualDiscussService.m
//  CarHome
//
//  Created by qianfeng on 15/10/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UsualDiscussService.h"
#import "AFHTTPRequestOperationManager.h"
#import "CarDiscuss.h"
#import "AreaModel.h"
#import "ThemeModel.h"
#import "ThemeDiscussModel.h"

@implementation UsualDiscussService
-(void)getCarTypeWithBlock:(ServiceBlock)myBlock AndParamter:(NSString *)para{
    NSString * path = [NSString stringWithFormat:@"%@%@",URL_USUAL,para];
    [[AFHTTPRequestOperationManager manager]GET:path
    parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject[@"result"]){
            NSDictionary * resultDic = responseObject[@"result"];
            NSMutableArray * resultArray = [NSMutableArray array];
            if(resultDic[@"list"]){
                NSArray * listArray = resultDic[@"list"];
                for(NSDictionary * dic in listArray){
                    if([para  isEqual: URL_CAR_TYPE]){
                        CarDiscuss * model = [[CarDiscuss new]initWithDictionay:dic];
                        [resultArray addObject:model];
                    }else if([para isEqual:URL_AREA]){
                        AreaModel * model = [[AreaModel new]initWithDictionary:dic];
                        [resultArray addObject:model];
                    }else{
                        ThemeModel * model = [[ThemeModel new]initWithDictionary:dic];
                        [resultArray addObject:model];
                    }
                    
                }
                myBlock(resultArray);
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getThemeDiscussWithPara:(NSString *)para basePara:(NSString *)basePara KindPara:(NSString *)kindPara andBlock:(ServiceBlock)myBlock andPage:(int)page{
    NSString * path = [NSString stringWithFormat:@"%@%@%@%d%@",basePara,para,kindPara,page,URL_UPDATE];
//    NSLog(@"%@",path);
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(responseObject[@"result"]){
            NSDictionary * resultDic = responseObject[@"result"];
            if(resultDic[@"list"]){
                NSArray * listArray = resultDic[@"list"];
                NSMutableArray * resultArray = [NSMutableArray array];
                for(NSDictionary * dic in listArray){
                    ThemeDiscussModel * model = [[ThemeDiscussModel new]initWithDictionary:dic];
                    [resultArray addObject:model];
                }
                myBlock(resultArray);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getAreaDiscussWithPara:(NSString *)para andBlock:(ServiceBlock)myBlock{
    NSString * path = [NSString stringWithFormat:@"%@%@%@",URL_BASE_AREA,para,URL_AREA_FIX_PARA];
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
