//
//  HotDiscussService.m
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotDiscussService.h"
#import "AFHTTPRequestOperationManager.h"
#import "HotDiscuss.h"

@implementation HotDiscussService
-(void)getHotDiscussWithPage:(int)page andBlock:(SerViceBlock)myBlock{
    NSString * path = [NSString stringWithFormat:@"%@%d%@",URL_DISCUSS_UPDATE,page,URL_DICUSS_FIX_PARA];
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * resultArr = [NSMutableArray array];
        if(responseObject[@"result"]){
            NSDictionary * listDic = responseObject[@"result"];
            NSArray * listArray = listDic[@"list"];
            for (NSDictionary * dic in listArray) {
                HotDiscuss * model = [[HotDiscuss alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            myBlock(resultArr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
