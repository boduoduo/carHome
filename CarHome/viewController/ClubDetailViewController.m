//
//  ClubDetailViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/19.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ClubDetailViewController.h"
#import "UIWebView+AFNetworking.h"
#import "ClubDetailDAO.h"
#import "ClubDetailVO.h"
static NSInteger PAGE_BUTTON_VIEW_PREFIX = 1654;
@interface ClubDetailViewController ()<UIWebViewDelegate>{
    UIWebView * _webView;
    UIActivityIndicatorView * _indicator;
    UIButton * _collectBtn;
    int _page;
    UILabel * _pageLabel;
    UILabel * _toastLabel;
    NSString * _path;
}

@end

@implementation ClubDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)configUI{
    UIView * naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    [self.view addSubview:naviView];
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 0, 40, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:0.3683 green:0.6215 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [naviView addSubview:backBtn];
    [backBtn addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(SCREEN_WIDTH-10-25, 30, 25, 25);
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_car_collected"] forState:UIControlStateNormal];
    [self.view addSubview:collectBtn];
    [collectBtn addTarget:self action:@selector(collectBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _collectBtn = collectBtn;
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-40)];
    [self.view addSubview:webView];
    _webView = webView;
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.center = self.view.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
    
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_icon_returntext_a"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(10, SCREEN_HEIGHT-30, 20, 20);
    [self.view addSubview:leftBtn];
    leftBtn.tag = PAGE_BUTTON_VIEW_PREFIX;
    [leftBtn addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"radio_in_icon"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH-10-20, SCREEN_HEIGHT-30, 20, 20);
    [self.view addSubview:rightBtn];
    rightBtn.tag = PAGE_BUTTON_VIEW_PREFIX+1;
    [rightBtn addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * pageLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-100)/2, SCREEN_HEIGHT-35, 100, 30)];
    pageLabel.textAlignment = NSTextAlignmentCenter;
    pageLabel.text = [NSString stringWithFormat:@"第%d页",_page];
    [self.view addSubview:pageLabel];
    _pageLabel = pageLabel;
    
}

-(void)createToastlabel{
    _toastLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-150)/2,SCREEN_HEIGHT*0.6, 150, 50)];
    _toastLabel.backgroundColor = [UIColor blackColor];
    _toastLabel.alpha = 0.8;
    _toastLabel.textColor = [UIColor whiteColor];
    _toastLabel.font = [UIFont systemFontOfSize:14];
    _toastLabel.textAlignment = NSTextAlignmentCenter;
    _toastLabel.hidden = YES;
    [self.view addSubview:_toastLabel];
}

-(void)showToastWithContent:(NSString *)contents{
    _toastLabel.text = contents;
    _toastLabel.hidden = NO;
    [UIView animateWithDuration:2 animations:^{
        _toastLabel.alpha = 0;
    } completion:^(BOOL finished) {
        _toastLabel.hidden = YES;
        _toastLabel.alpha = 0.8;
    }];
}

-(void)loadData{
    if (_webPath) {
        _path = _webPath;
    }else{
        if([_module isEqualToString:@"three"]){
            _path = [NSString stringWithFormat:@"%@%@-%@-%d%@",URL_CLUB_DETAIL,_bbsid,_topcid,_page,URL_CLUB_FIX_PARA];
        }else {
            _path = [NSString stringWithFormat:@"%@%@-o0-p%d%@",URL_HOTDISCUSS_DETAIL,_topcid,_page,HOT_DISCUSS_DEYAIL_PARA];
        }

    }
    NSURL * url = [NSURL URLWithString:_path];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self load:request];
}

-(void)load:(NSURLRequest *)request{
     [_webView loadRequest:request MIMEType:nil textEncodingName:nil progress:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
         if(totalBytesExpectedToWrite > 0.2 *totalBytesWritten){
             [_indicator stopAnimating];
         }
     } success:nil  failure:nil];
}


-(void)loadFailed{
    UIImageView * failedImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2, SCREEN_HEIGHT*0.4, 200, 300)];
    failedImageView.image = [UIImage imageNamed:@"loadfaild"];
    [self.view addSubview:failedImageView];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self loadFailed];
}

-(void)backButtonClicked:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)collectBtnClicked:(UIButton *)sender{
    ClubDetailVO * model = [ClubDetailVO new];
    model.pathString = _path;
    static int state = 0;
    [self createToastlabel];
    if(!state){
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_car_collected_check"] forState:UIControlStateNormal];
            [self showToastWithContent:@"收藏成功"];
        [[[ClubDetailDAO alloc]init] save:model];
    }else{
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"bar_btn_car_collected"] forState:UIControlStateNormal];
            [self showToastWithContent:@"取消收藏"];
        [[[ClubDetailDAO alloc]init] dele:model];
    }
    state = !state;
}

-(void)pageChange:(UIButton *)sender{
    if(sender.tag >=PAGE_BUTTON_VIEW_PREFIX){
        if(sender.tag == PAGE_BUTTON_VIEW_PREFIX){
            _page--;
            if(_page == 0){
                _page = 1;
                return;
            }
        }else if (sender.tag == PAGE_BUTTON_VIEW_PREFIX+1){
            _page++;
        }
    }
    [self loadData];
    _pageLabel.text = [NSString stringWithFormat:@"第%d页",_page];
}

@end
