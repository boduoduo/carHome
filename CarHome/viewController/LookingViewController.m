//
//  LookingViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LookingViewController.h"
#import "LookingCarHeadView.h"
#import "LookingCarService.h"
#import "CarBrandModel.h"
#import "BrandDetailModel.h"
#import "UIButton+WebCache.h"
#import "CarPriceModel.h"
#import "CarTypeModel.h"
#import "UIImageView+WebCache.h"
#import "CarPriceTableViewCell.h"
#import "CutPriceTableViewCell.h"
#import "CutPriceModel.h"
#import "DealerModel.h"
#import "MJRefresh.h"

static NSInteger TOP_BUTTON_VIEW_TAG_PREFIX = 9524;

@interface LookingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    UITableView *_detailTableView;
    NSArray * _LetterList;
    NSArray * _priceArray;
    NSArray * _cutPriceArray;
    UIActivityIndicatorView * _indicator;
    UIActivityIndicatorView * _indicatorDetail;
    UITableView * _cutPriceTableView;
    int _page;
}
@property(nonatomic,strong)UIButton * brandBtn;
@property(nonatomic,strong)UIButton * cutPriceBtn;
@property(nonatomic,strong)UIView * moveLine;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIWebView * phoneCallWebView;

@end

@implementation LookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    [self configUI];
    _cutPriceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self updateData];
    [self loadAnimation:_tableView];
    [self createTitleView];
    [self createHeadView];
    [self loadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)createHeadView{
    NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"LookingCarHeadView" owner:self options:nil];
    UIView * headView = [nib objectAtIndex:0];
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    _tableView.tableHeaderView = headView;
}

-(void)loadAnimation:(UITableView *)tableView{
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.center = tableView.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)configUI{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UISwipeGestureRecognizer * swipeone = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(cutPrice:)];
    swipeone.direction = UISwipeGestureRecognizerDirectionLeft;
    [_tableView addGestureRecognizer:swipeone];
    
    UITableView * cutPriceTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:cutPriceTableView];
    _cutPriceTableView = cutPriceTableView;
    _cutPriceTableView.delegate = self;
    _cutPriceTableView.dataSource = self;
    [_cutPriceTableView registerNib:[UINib nibWithNibName:@"CutPriceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cutPriceCell"];
    
    UISwipeGestureRecognizer * rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(cutPriceBack:)];
    [_cutPriceTableView addGestureRecognizer:rightSwipe];
    
    
    UITableView * detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 60, SCREEN_WIDTH*0.8, SCREEN_HEIGHT-60-44) style:UITableViewStyleGrouped];
    [self.view addSubview:detailTableView];
    _detailTableView = detailTableView;
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    [_detailTableView registerNib:[UINib nibWithNibName:@"CarPriceTableViewCell" bundle:nil] forCellReuseIdentifier:@"carpriceCell"];
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.8, 30)];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH*0.8-150)/2, 10, 150, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    detailTableView.tableHeaderView = headView;
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(backTableView:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [_detailTableView addGestureRecognizer:swipe];
    
}

-(void)createTitleView{
    for(int i =0;i<2;i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((SCREEN_WIDTH-60*2-30)/2+(30+30)*i, 20, 60, 30);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(brandCame:) forControlEvents:UIControlEventTouchUpInside];
        if(i == 0){
            [btn setTitle:@"品牌" forState:UIControlStateNormal];
            _brandBtn = btn;
            _brandBtn.tag = TOP_BUTTON_VIEW_TAG_PREFIX;
            [_brandBtn setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
            [self.view addSubview:_brandBtn];
        }else{
            [btn setTitle:@"降价" forState:UIControlStateNormal];
            _cutPriceBtn = btn;
            _cutPriceBtn.tag = TOP_BUTTON_VIEW_TAG_PREFIX+1;
            [self.view addSubview:_cutPriceBtn];
        }
    }
    _moveLine = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-50*2-30)/2, 55, 40,2)];
    _moveLine.backgroundColor = [UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0];
    [self.view addSubview:_moveLine];
    
}


#pragma mark -- 网络请求数据及刷新

-(void)updateData{
    __block LookingViewController* blockSelf = self;
    
    // 添加下拉刷新
    _cutPriceTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [blockSelf loadCutPriceData];
        
        // 表示N = 5秒之后结束Refreshing
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_cutPriceTableView.header endRefreshing];
        });
    }];
    
    // 添加上拉加载更多
    _cutPriceTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [blockSelf getNextData];
        
        // 表示N = 5秒之后结束Refreshing
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_cutPriceTableView.footer endRefreshing];
        });
    }];
}

-(void)getNextData{
    _page++;
    [self loadCutPriceData];
}

-(void)loadData{
    [[LookingCarService new]getLookingCarWithBlock:^(id data) {
        _LetterList = data;
        if(_LetterList.count>0){
            [_indicator stopAnimating];
        }
        [_tableView reloadData];
    }];
}

-(void)loadPriceData:(NSString *)CarId{
    [[LookingCarService new]getCarDetailWithID:CarId andBlock:^(id data) {
        _priceArray = data;
        if(_priceArray.count>0){
            [_indicatorDetail stopAnimating];
        }
        [_detailTableView reloadData];
    }];
}

-(void)loadFailed{
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.center = _detailTableView.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicatorDetail = indicator;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)loadCutPriceData{
    [[LookingCarService new]getCutPriceWithPage:_page andBlock:^(id data) {
        _cutPriceArray = data;
        if(_cutPriceArray.count>0){
           [_indicator stopAnimating];
        }
        [_cutPriceTableView reloadData];
    }];
}

#pragma mark -- tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _tableView)
    {
        CarBrandModel * mo = _LetterList[section];
        NSArray * array = mo.list;
        return array.count;
    }
    else if(tableView == _cutPriceTableView)
    {
        return _cutPriceArray.count;
    }
    else{
        CarTypeModel * mo = _priceArray[section];
        NSArray * array = mo.serieslist;
        return array.count;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(tableView == _tableView){
        return _LetterList.count;
    }
    else if(tableView == _cutPriceTableView)
    {
        return 1;
    }
    else{
        return _priceArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView){
        _indicator.center = _detailTableView.center;
        [_indicator startAnimating];
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CarBrandModel * mo = _LetterList[indexPath.section];
        NSDictionary * dic = mo.list[indexPath.row];
        BrandDetailModel * model = [[BrandDetailModel new]initWithDictionary:dic];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(5, 5, 34, 34);
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imgurl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"carback"]];
        [cell.contentView addSubview:btn];
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 12, 150, 20)];
        nameLabel.text = model.name;
        [cell.contentView addSubview:nameLabel];
        return cell;
    }else if(tableView == _detailTableView){
        CarTypeModel * mo = _priceArray[indexPath.section];
        NSDictionary * dic = mo.serieslist[indexPath.row];
        CarPriceModel * model = [[CarPriceModel new]initWithDictionary:dic];
        CarPriceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"carpriceCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgurl] placeholderImage:[UIImage imageNamed:@"carback"]];
        cell.titleLabel.text = model.name;
        cell.decripLabel.text = model.levelname;
        cell.priceLabel.text = [NSString stringWithFormat:@"¥:%@",model.price];
        return cell;
    }else{
        CutPriceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cutPriceCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CutPriceModel * model = _cutPriceArray[indexPath.row];
        NSDictionary * dic = model.dealer;
        DealerModel * mo = [[DealerModel new]initWithDictionary:dic];
        cell.titleLabel.text = model.specname;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.specpic] placeholderImage:[UIImage imageNamed:@"carback"]];
        cell.priceLabel.text = [NSString stringWithFormat:@"%@万",model.dealerprice];
        cell.oldPriceLabel.text = [NSString stringWithFormat:@"%@万",model.fctprice];
        cell.addressLabel.text = mo.city;
        cell.companyLabel.text = [NSString stringWithFormat:@"|%@",mo.name];
        cell.sellWhereLabel.text = mo.orderrange;
        cell.cutPriceLabel.text = [NSString stringWithFormat:@"降%.2f万",[model.fctprice floatValue] - [model.dealerprice floatValue]];
        cell.gouImageView.image = [UIImage imageNamed:@"gou"];
        cell.callLabel.text = mo.phone;
        if(mo.is400.intValue){
            cell.amoutLabel.text = @"现车充足";
        }else{
           cell.amoutLabel.text = @"少量现车";
        }
        
        return cell;
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView == _tableView){
        CarBrandModel * model = _LetterList[section];
        return model.letter;
    }else if(tableView == _cutPriceTableView){
        return nil;
    }
    else{
        CarTypeModel * model = _priceArray[section];
        return model.name ;
    }
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView){
        _priceArray = nil;
        CarBrandModel * mo = _LetterList[indexPath.section];
        NSDictionary * dic = mo.list[indexPath.row];
        BrandDetailModel * model = [[BrandDetailModel new]initWithDictionary:dic];
        _titleLabel.text = model.name;
        [self loadFailed];
            [self loadPriceData:[NSString stringWithFormat:@"%@",model.BrandId]];
        [UIView animateWithDuration:0.3 animations:^{
            _detailTableView.frame = CGRectMake(SCREEN_WIDTH*0.1, 60, SCREEN_WIDTH*0.9, SCREEN_HEIGHT-60-44);
        } completion:^(BOOL finished) {
            _tableView.userInteractionEnabled = NO;
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableView){
        return 44;
    }else if(tableView == _detailTableView){
        return 60;
    }else{
        return 110;
    }
}

#pragma mark -- 手势事件处理

-(void)backTableView:(UISwipeGestureRecognizer *)swipe{
    [UIView animateWithDuration:0.3 animations:^{
        _detailTableView.frame = CGRectMake(SCREEN_WIDTH, 60, SCREEN_WIDTH*0.8, SCREEN_HEIGHT-60-44);
    }];
    _tableView.userInteractionEnabled = YES;
}

-(void)cutPrice:(UISwipeGestureRecognizer *)swipe{
    [self loadCutPriceData];
    [UIView animateWithDuration:0.4 animations:^{
        _cutPriceTableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tableView.frame = CGRectMake(-SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        _moveLine.frame = CGRectMake((SCREEN_WIDTH-50*2-30)/2+60, 55, 40,2);
    }];
        [self loadAnimation:_cutPriceTableView];
    [self changeColor];
}

-(void)cutPriceBack:(UISwipeGestureRecognizer *)swipe {
    [UIView animateWithDuration:0.4 animations:^{
        _cutPriceTableView.frame = CGRectMake(SCREEN_WIDTH, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        _tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT);
        _moveLine.frame = CGRectMake((SCREEN_WIDTH-50*2-30)/2, 55, 40,2);
    }];
//    [_indicator stopAnimating];
    [self changeBackColor];
}

-(void)brandCame:(UIButton *)sender{
    if(sender.tag>=TOP_BUTTON_VIEW_TAG_PREFIX){
        if(sender.tag == TOP_BUTTON_VIEW_TAG_PREFIX){
            [self cutPriceBack:nil];
            [self changeBackColor];
        }else {
            [self changeColor];
            [self cutPrice:nil];
        }
    }
}

-(void)changeColor{
    [_brandBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cutPriceBtn setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
}

-(void)changeBackColor{
    [_brandBtn setTitleColor:[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [_cutPriceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

 @end
