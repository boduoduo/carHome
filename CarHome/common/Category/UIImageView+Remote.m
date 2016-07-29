//
//  UIImageView+Remote.m
//  GraduationProjectNetworkCR
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UIImageView+Remote.h"

@implementation UIImageView (Remote)
-(void)setImageWithURLString:(NSString *)urlString{
    NSString *imageName = urlString;
    UIImage *image = [self getImage:imageName];
    if (image) {
        [self setImage:image];
    }else{
        NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURLRequest *requst = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:requst queue:[NSOperationQueue mainQueue] completionHandler:
         ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
             if (data) {
                 [self setImage:[UIImage imageWithData:data]];
                 [self saveImage:data imageName:imageName];
             }
         }];
    }
}

-(void)saveImage:(NSData *)data imageName:(NSString *)imageName{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * base64String = [[imageName dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:kNilOptions];
    NSString * path = [NSString stringWithFormat:@"%@/%@", documentPath, base64String];
    [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
}


-(UIImage *)getImage:(NSString *)imageName{
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * base64String = [[imageName dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:kNilOptions];
    NSString * path = [NSString stringWithFormat:@"%@/%@", documentPath, base64String];
    NSData * data = [[NSFileManager defaultManager] contentsAtPath:path];
    if (data) {
        return [UIImage imageWithData:data];
    }
    return nil;
}
@end
