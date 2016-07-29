//
//  WebViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import "WebViewController.h"
#import "UIWebView+AFNetworking.h"
#import "UMSocial.h"
#import "WebVO.h"
#import "WebDAO.h"
@interface WebViewController ()<UMSocialUIDelegate>{
    
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIButton *leftBtn;
    __weak IBOutlet UIButton *rightBtn1;
    __weak IBOutlet UIButton *rightBtn2;
    __weak IBOutlet UIWebView *webView;
    NSString *pathString ;
    int num ;
    int state;
    UIActivityIndicatorView * _indicator;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadAnimation];
    
    num = 1;
    state =1;
}

-(void)configUI{
    if (_newsId) {
         if (_mediatypeString) {
            if (_mediatypeString.integerValue == 3) {
                pathString = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.9.5/content/news/videopage-a2-pm2-v4.9.5-vid%d-night0-showpage1-fs1-cw360.json",_newsId.intValue];
            }else{
                pathString = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.9.5/content/news/newscontent-n%d-t0.json",_newsId.intValue];
            }
        }else{
            if (_videoAddressString) {
                pathString = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.9.5/content/news/videopage-a2-pm2-v4.9.5-vid%d-night0-showpage1-fs1-cw360.json",_newsId.intValue];
            }else{
                pathString = [NSString stringWithFormat:@"http://sp.autohome.com.cn/news/news_V3_0.aspx?newsid=%d&pageIndex=1&nolazyLoad=0&spmodel=0&showad=1",_newsId.intValue];
                
                }
            }
    }else{
        pathString = _webString;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:pathString]];
    [webView loadRequest:request];
    [self doRequest:request];
}

- (IBAction)Clicked:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadAnimation{
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.center = [UIApplication sharedApplication].keyWindow.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
}

-(void)doRequest:(NSURLRequest *)request{
    [webView loadRequest:request MIMEType:nil textEncodingName:nil progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        if(totalBytesExpectedToWrite > 0.3 *totalBytesWritten){
            [_indicator stopAnimating];
        }
    } success:nil  failure:nil];
}
- (IBAction)rightBtn1:(id)sender {
    [UMSocialData defaultData].extConfig.qqData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.qzoneData.title = @"CarHome";
    [UMSocialData defaultData].extConfig.qqData.url = @"https://itunes.apple.com/cn/app/id1047667835";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"https://itunes.apple.com/cn/app/id1047667835";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://itunes.apple.com/cn/app/id1047667835";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"https://itunes.apple.com/cn/app/id1047667835";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561f6d3fe0f55a753e001969"
                                      shareText:@"爱车，爱生活"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToQQ,UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline,UMShareToSina,nil]
                                delegate:self];

}
- (IBAction)rightBtn2:(id)sender {
    WebVO * model = [[WebVO alloc]init];
    model.webString = pathString;
    if (state == 1) {
                [rightBtn2 setImage:[UIImage imageNamed:@"nav_star_p"] forState:UIControlStateNormal];
        [[[WebDAO alloc]init] save:model];
    }else{
       
        [rightBtn2 setImage:[UIImage imageNamed:@"nav_star"] forState:UIControlStateNormal];
        [[[WebDAO alloc]init] dele:model];
    }
    state = !state;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
