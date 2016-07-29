//
//  UsualDiscussModel.m
//  CarHome
//
//  Created by qianfeng on 15/10/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UsualDiscussModel.h"



@implementation UsualDiscussModel

-(NSString *)description{
    return [NSString stringWithFormat:@"图片：%@, 标题：%@,详细：%@",_imageName,_titleName,_detail];
}
@end
