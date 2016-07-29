//
//  AppService.m
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppService.h"
#import "AFHTTPRequestOperationManager.h"
#import "TitleNew1VO.h"
#import "ADNew1VO.h"
#import "NewNew1VO.h"
#import "ADSNew1VO.h"
#import "BulletinVO.h"
#import "videoVO.h"
#import "NewsVO.h"
#import "TestVO.h"
#import "BulletinChooseVO.h"
#import "BulletinChooseListVO.h"
#import "ModelcarVO.h"
@interface AppService(){
    TitleNew1VO * model1;
    ADSNew1VO * model2;
}
@end

@implementation AppService
-(UIImage *)getImage:(NSString *)str{
    NSURL * url = [NSURL URLWithString:str];
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:nil];
    if (data) {
        UIImage *image = [UIImage imageWithData:data];
        return image;
    }
    return nil;
}

-(void)getRecommendAppByNum:(int)num handle:(AppServiceHandle)handle{
    NSString * path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm2-c0-nt0-p1-s20-l%d.json",num];
    [self getRecommendAppWithPath:path handle:handle];
}

-(void)getRecommend1AppByNum:(int)num b:(int)b levelid:(int)levelid handle:(AppServiceHandle)handle{
    NSString * path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/fastnewslist-pm2-b%d-l%d-s20-lastid%d.json",b,levelid,num];
    [self getRecommend1AppWithPath:path handle:handle];
}

-(void)getRecommend2AppByNum:(int)num vt:(int)vt handle:(AppServiceHandle)handle{
    NSString * path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/videolist-pm2-vt%d-s20-lastid%d.json",vt,num];
    [self getRecommend2AppWithPath:path handle:handle];
}

-(void)getRecommend3AppByNum:(int)num handle:(AppServiceHandle)handle{
    NSString * path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm2-c0-nt1-p1-s20-l%d.json",num];
    [self getRecommend3AppWithPath:path handle:handle];
}

-(void)getRecommend4AppByNum:(int)num handle:(AppServiceHandle)handle{
    NSString * path = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov5.0.0/news/newslist-pm2-c0-nt3-p1-s20-l%d.json",num];
    [self getRecommend4AppWithPath:path handle:handle];
}

-(void)getRecommendAppWithPath:(NSString *)path handle:(AppServiceHandle)handle{
    model1 = [[TitleNew1VO alloc]init];
    model2 = [[ADSNew1VO alloc]init];
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray * resultArr = [NSMutableArray array];
        NSMutableArray * resultArr1 = [NSMutableArray array];
        NSMutableArray * resultArr2 = [NSMutableArray array];
       
        if(responseObject[@"result"]){
            if (responseObject[@"result"][@"headlineinfo"]) {
                TitleNew1VO * model = [[TitleNew1VO alloc]initWithDictionary:responseObject[@"result"][@"headlineinfo"]];
                model = model1;
            }
            if(responseObject[@"result"][@"focusimg"]){
                NSArray * arr = responseObject[@"result"][@"focusimg"];
                for (NSDictionary *dic in arr) {
                    ADNew1VO * model = [[ADNew1VO alloc]initWithDictionary:dic];
                    [resultArr1 addObject:model];
                }
            }
            if(responseObject[@"result"][@"newslist"]) {
                NSArray * arr = responseObject[@"result"][@"newslist"];
                for (NSDictionary*dic in arr) {
                    NewNew1VO *model = [[NewNew1VO alloc]initWithDictionary:dic];
                    [resultArr2 addObject:model];
                }
            }
            if(responseObject[@"result"][@"topnewsinfo"]){
                ADSNew1VO * model = [[ADSNew1VO alloc]initWithDictionary:responseObject[@"result"][@"topnewsinfo"]];
                model = model2;
            }
        }
        
        [resultArr addObject:model1];
        [resultArr addObject:resultArr1];
        [resultArr addObject:resultArr2];
        [resultArr addObject:model2];
        handle(resultArr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getRecommend1AppWithPath:(NSString *)path handle:(AppServiceHandle)handle{
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject[@"result"][@"list"]) {
            NSMutableArray * resultArr =[NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"result"][@"list"]) {
                BulletinVO *model =[[BulletinVO alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            handle(resultArr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getRecommend2AppWithPath:(NSString *)path handle:(AppServiceHandle)handle{
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject[@"result"][@"list"]) {
            NSMutableArray * resultArr =[NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"result"][@"list"]) {
                videoVO *model =[[videoVO alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            handle(resultArr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getRecommend3AppWithPath:(NSString *)path handle:(AppServiceHandle)handle{
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject[@"result"][@"newslist"]) {
            NSMutableArray * resultArr =[NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"result"][@"newslist"]) {
                NewsVO *model =[[NewsVO alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            handle(resultArr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getRecommend4AppWithPath:(NSString *)path handle:(AppServiceHandle)handle{
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject[@"result"][@"newslist"]) {
            NSMutableArray * resultArr =[NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"result"][@"newslist"]) {
                TestVO *model =[[TestVO alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            handle(resultArr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)getBulletinChooseHandle:(AppServiceHandle)handle{
    NSString *path = @"http://app.api.autohome.com.cn/autov5.0.0/news/brandsfastnews-pm2-ts0.json";
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (responseObject[@"result"])
        {
            NSMutableArray * resultArray  = [NSMutableArray array];
            NSDictionary * dic1 = responseObject[@"result"];
            
            if (dic1) {
                if (dic1[@"brandlist"]) {
                    NSMutableArray * resultArr = [NSMutableArray array];
                    for (NSDictionary *dic in dic1[@"brandlist"]) {
                        BulletinChooseVO *model = [[BulletinChooseVO alloc]initWithDictionary:dic];
                        [resultArr addObject:model];
                    }
                    [resultArray addObject:resultArr];
                }
            }
        
        if (responseObject[@"result"][@"brandlist"]) {
            NSMutableArray * resultArr = [NSMutableArray array];
            for (NSDictionary *dic in responseObject[@"result"][@"brandlist"]) {
                if (dic[@"list"]) {
                    NSMutableArray *result = [NSMutableArray array];
                    for (NSDictionary *dic1 in dic[@"list"]) {
                        BulletinChooseListVO *model = [[BulletinChooseListVO alloc]initWithDictionary:dic1];
                        [result addObject:model];
                    }
                    [resultArr addObject:result];
                }
                [resultArray addObject:resultArr];
            }
        }
             handle(resultArray);
    }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

//-(void)getgetBulletinChooseListHandle:(AppServiceHandle)handle{
//    NSString *path = @"http://app.api.autohome.com.cn/autov5.0.0/news/brandsfastnews-pm2-ts0.json";
//    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (responseObject[@"result"][@"brandlist"]) {
//            NSMutableArray * resultArr = [NSMutableArray array];
//            for (NSDictionary *dic in responseObject[@"result"][@"brandlist"]) {
//                if (dic[@"list"]) {
//                    NSMutableArray *result = [NSMutableArray array];
//                    for (NSDictionary *dic1 in dic[@"list"]) {
//                        BulletinChooseListVO *model = [[BulletinChooseListVO alloc]initWithDictionary:dic1];
//                        [result addObject:model];
//                    }
//                    [resultArr addObject:result];
//                }
//                handle(resultArr);
//            }
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}

-(void)getModelCarHandle:(AppServiceHandle)handel{
    NSString * path = @"http://app.api.autohome.com.cn/autov5.0.0/news/fastnewslevel-pm2-ts0.json";
    [[AFHTTPRequestOperationManager manager]GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (responseObject[@"result"][@"list"]) {
            NSMutableArray * resultArr = [NSMutableArray array];
            for (NSDictionary * dic in responseObject[@"result"][@"list"]) {
                ModelcarVO * model = [[ModelcarVO alloc]initWithDictionary:dic];
                [resultArr addObject:model];
            }
            handel(resultArr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
