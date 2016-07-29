//
//  DiscussViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DiscussViewController.h"
#import "JingHuaService.h"
#import "JingXuanTableViewCell.h"
#import "CarHomeModel.h"
#import "UIImageView+WebCache.h"
#import "HotDiscussTableViewCell.h"
#import "UsualDiscussTableViewCell.h"
#import "HotDiscuss.h"
#import "UsualDiscussModel.h"
#import "UsualDiscussViewController.h"
#import "AreaDiscussViewController.h"
#import "ThemeViewController.h"
#import "ClubDetailViewController.h"
#import "MJRefresh.h"
#import "HotDiscussService.h"
#import "CarHomeDAO.h"
#import "HotDiscussDAO.h"


#define TITLE_WIDTH 100
#define TITLE_HEIFGT 40
#define SPACE_TITLE_WIDTH (SCREEN_WIDTH-3*TITLE_WIDTH-10*2)/2
static long BUTTON_TAG_VIEW_PREFIX = 16546;


@interface DiscussViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSArray * _dataList;
    NSArray * _HotDiscussData;
    NSMutableArray * _usualDiscussData;
    UITableView * _tableOne;
    UITableView * _tableTwo;
    UITableView * _tableThree;
    UIActivityIndicatorView * _indicator;
    int _page;
    int _state;
    
}
@property (weak, nonatomic) IBOutlet UIView *moveLine;
@property (weak, nonatomic) IBOutlet UIButton *jingXuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *hotDiscuss;
@property (weak, nonatomic) IBOutlet UIButton *usualDiscuss;
@property (weak, nonatomic) IBOutlet UIScrollView *moveScrollView;
@property(nonatomic,strong)UIView * baseView;
@property(nonatomic,strong)UIColor * chooseColor;
@end

@implementation DiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _chooseColor = [UIColor colorWithRed:0.2717 green:0.5104 blue:1.0 alpha:1.0];
    _state = 1;
    [self configUI];
    [self loadAnimation];
    [self loadData:CAR_HOME];
    [self updateData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadAnimation{
    UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    indicator.color = [UIColor blackColor];
    indicator.center = self.view.center;
    [indicator startAnimating];
    indicator.hidesWhenStopped = YES;
    _indicator = indicator;
    _tableOne.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableTwo.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark -- 数据请求
-(void)updateData{
    NSArray * tableViewArray = @[_tableOne,_tableTwo];
    __block DiscussViewController * blockSelf = self;
    //添加下拉刷新
    for(int i = 0;i<2;i++){
        UITableView * tableView = tableViewArray[i];
        tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [blockSelf refreshData:tableView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([tableView.header isRefreshing]) {
                    [tableView.header endRefreshing];
                }
            });
        }];
        tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [blockSelf getNextData:tableView];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([tableView.footer isRefreshing]) {
                    [tableView.footer endRefreshing];
                }
            });
        }];
        
    }
    
}

-(void)refreshData:(UITableView *)tableView{
    if(tableView == _tableOne){
        NSString * str = [self judgeModule];
        [[JingHuaService new]getCarHomeWithPage:1 andBlock:^(id data) {
            _dataList = data;
            [_tableOne reloadData];
        } paramter:str];
    }else if (tableView == _tableTwo){
        [[HotDiscussService new]getHotDiscussWithPage:1 andBlock:^(id data) {
            _HotDiscussData = data;
            if ([_tableTwo.header isRefreshing]) {
                [_tableTwo.header endRefreshing];
            }
            [_tableTwo reloadData];
        }];
    }
    
}

-(void)getNextData:(UITableView *)tableView{
    _page++;
    NSString * str = [self judgeModule];
    if(tableView == _tableOne){
        [[JingHuaService new]getCarHomeWithPage:_page andBlock:^(id data) {
            _dataList =data;
            [_tableOne reloadData];
        } paramter:str];
    }else if (tableView == _tableTwo){
        [[HotDiscussService new]getHotDiscussWithPage:_page andBlock:^(id data) {
            _HotDiscussData = data;
            if ([_tableTwo.footer isRefreshing]) {
                [_tableTwo.footer endRefreshing];
            }
            [_tableTwo reloadData];
        }];
    }
    
}

//判断是那个模块
-(NSString *)judgeModule{
    NSString * str = [NSString string];
    if(_state == 1){
        str = CAR_HOME;
    }else if (_state == 2){
        str = WIFE_MODEL;
    }else{
        str = Beauty_DIARY;
    }
    return str;
}

-(void)loadData:(NSString *)para{
    [[JingHuaService new]getCarHomeWithBlock:^(id data) {
        if ([_tableOne.header isRefreshing]) {
            [_tableOne.header endRefreshing];
        }
        _dataList = data;
        [_tableOne reloadData];
        if(_dataList.count>0){
            [_indicator stopAnimating];
        }
    } paramter:para];
}



-(void)loadHotDiscussData{
    [[JingHuaService new]getHotDiscussWithBlock:^(id data) {
        if ([_tableTwo.header isRefreshing]) {
            [_tableTwo.header endRefreshing];
        }
        _HotDiscussData = data;
        if(_HotDiscussData.count >0){
            [_indicator stopAnimating];
        }
        [_tableTwo reloadData];
    }];
}

-(void)loadUsualDiscussData{
    NSArray * imageArray = @[@"forum_icon_auto",@"forum_icon_location",@"forum_icon_theme"];
    NSArray * titleName = @[@"车系论坛",@"地区论坛",@"主题论坛"];
    NSArray * detailArray = @[@"为你的爱车找到队伍",@"老乡见老乡，两眼泪汪汪",@"兴趣爱好的聚集地"];
    _usualDiscussData = [NSMutableArray array];
    for(int i=0;i<3;i++){
        UsualDiscussModel * model = [UsualDiscussModel new];
        model.titleName = titleName[i];
        model.detail = detailArray[i];
        model.imageName = imageArray[i];
        [_usualDiscussData addObject:model];
    }
//    NSLog(@"%@",_usualDiscussData);
    [_tableThree reloadData];
}

#pragma mark -- 界面配置
-(void)configUI{
//    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray * array = @[@"汽车之家十年",@"媳妇当车模",@"美人“记”"];
    for(int i=0;i<3;i++){
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(SPACE_TITLE_WIDTH+(TITLE_WIDTH+10)*i, 0, TITLE_WIDTH, TITLE_HEIFGT);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = BUTTON_TAG_VIEW_PREFIX+i;
        [btn addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
        [_moveScrollView addSubview:btn];
    }
    int height = 40;
    for(int j=0;j<3;j++){
       height = j == 0?  40: 0;
        
        UITableView * carTable = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*j, height, SCREEN_WIDTH, SCREEN_HEIGHT-67) style:UITableViewStylePlain];
        carTable.delegate = self;
        carTable.dataSource = self;
        carTable.tableFooterView = [[UIView alloc]init];
        carTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_moveScrollView addSubview:carTable];
        if(j==0){
            _tableOne = carTable;
            [_tableOne registerNib:[UINib nibWithNibName:@"JingXuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"jinghuaCell"];
        }else if (j==1){
            _tableTwo = carTable;
            [_tableTwo registerNib:[UINib nibWithNibName:@"HotDiscussTableViewCell" bundle:nil] forCellReuseIdentifier:@"hotDiscussCell"];
        }else{
            _tableThree = carTable;
            [_tableThree registerNib:[UINib nibWithNibName:@"UsualDiscussTableViewCell" bundle:nil] forCellReuseIdentifier:@"UsualDiscussCell"];
        }
}
    //因为tableView的高度不固定，所以画布的高度的也不能确定，
    _moveScrollView.contentSize = CGSizeMake(3*SCREEN_WIDTH, 0);
    _moveScrollView.contentOffset = CGPointMake(0, 0);
    _moveScrollView.pagingEnabled = YES;
    _moveScrollView.bounces = NO;
    _moveScrollView.showsHorizontalScrollIndicator = NO;
    _moveScrollView.delegate = self;
   
}

#pragma mark -- scrolllView代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger  index = scrollView.contentOffset.x/self.view.bounds.size.width;
    if(index==0){
        [self loadData:CAR_HOME];
        [self moveAnimation:_jingXuanBtn];
    }else if(index==1){
        [self loadHotDiscussData];
        [self moveAnimation:_hotDiscuss];
    }else {
        [self loadUsualDiscussData];
        [self moveAnimation:_usualDiscuss];
        
    }
}

#pragma mark--tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _tableOne){
        return _dataList.count;
    }else if (tableView == _tableTwo){
        return _HotDiscussData.count;
    }else{
        return _usualDiscussData.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableOne){
        JingXuanTableViewCell * jingHuaCell = [tableView dequeueReusableCellWithIdentifier:@"jinghuaCell" forIndexPath:indexPath];
        jingHuaCell.selectionStyle = UITableViewCellSelectionStyleNone;
        CarHomeModel * model = _dataList[indexPath.row];
        [jingHuaCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.smallpic]placeholderImage:[UIImage imageNamed:@"carback"]];
        jingHuaCell.nameLabel.text = model.title;
        jingHuaCell.detailLabel.text = model.bbsname;
        jingHuaCell.answerLabel.text = [NSString stringWithFormat:@"%@回帖",model.replycounts];
        return jingHuaCell;
    }else if(tableView == _tableTwo){
        HotDiscussTableViewCell * hotdiscussCell = [tableView dequeueReusableCellWithIdentifier:@"hotDiscussCell" forIndexPath:indexPath];
        hotdiscussCell.selectionStyle = UITableViewCellSelectionStyleNone;
        HotDiscuss * model = _HotDiscussData[indexPath.row];
        hotdiscussCell.titleLabel.text = model.title;
        hotdiscussCell.timeLabel.text = [NSString stringWithFormat:@"%@ %@",model.bbsname,model.postdate];
        hotdiscussCell.replyLabel.text = [NSString stringWithFormat:@"%@回帖",model.replycounts];
        NSNumber * nu =  model.ispictopic;
        if([nu intValue]){
            hotdiscussCell.picImagView.image = [UIImage imageNamed:@"forum_icon_pic"];
        }
        return hotdiscussCell;
    }else if(tableView == _tableThree){
        UsualDiscussTableViewCell * usualDiscussCell = [tableView dequeueReusableCellWithIdentifier:@"UsualDiscussCell" forIndexPath:indexPath];
        usualDiscussCell.selectionStyle = UITableViewCellSelectionStyleNone;
        UsualDiscussModel * model = _usualDiscussData[indexPath.row];
        usualDiscussCell.iconImageView.image = [UIImage imageNamed:model.imageName];
        usualDiscussCell.titleLabel.text = model.titleName;
        usualDiscussCell.detailLabel.text = model.detail;
        return usualDiscussCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _tableThree){
        if(indexPath.row == 0){
            UsualDiscussViewController * UDVC = [[UsualDiscussViewController alloc]init];
            [self presentViewController:UDVC animated:YES completion:nil];
        }else if (indexPath.row == 1){
            AreaDiscussViewController * ADVC = [[AreaDiscussViewController alloc]init];
            [self presentViewController: ADVC animated:YES completion:nil];
        }else{
            ThemeViewController * TVC = [[ThemeViewController alloc]init];
            [self presentViewController:TVC animated:YES completion:nil];
        }
        
    }if(tableView == _tableTwo){
        ClubDetailViewController * CDVC = [[ClubDetailViewController alloc]init];
        HotDiscuss * model = _HotDiscussData[indexPath.row];
        [[[HotDiscussDAO alloc]init]save:model];
        CDVC.bbsid = [NSString stringWithFormat:@"%@",model.bbsid];
       
        CDVC.topcid = [NSString stringWithFormat:@"%@",model.topicid];
         NSLog(@"%@",model.topicid);
        CDVC.module = @"two";
        CDVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:CDVC animated:YES completion:nil];
    }if(tableView == _tableOne){
        ClubDetailViewController * CDVC = [[ClubDetailViewController alloc]init];
        CarHomeModel * model = _dataList[indexPath.row];
        [[CarHomeDAO new]save:model];
        CDVC.bbsid = [NSString stringWithFormat:@"%@",model.bbsid];
        CDVC.topcid = [NSString stringWithFormat:@"%@",model.topicid];
         CDVC.module = @"one";
        CDVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:CDVC animated:YES completion:nil];
    }
}

#pragma mark --点击事件处理
-(void)changeViewController:(UIButton *)sender{
    if(sender.tag>=BUTTON_TAG_VIEW_PREFIX){
    
        if(sender.tag == BUTTON_TAG_VIEW_PREFIX+1){
            _state = 2;
            [self loadData:WIFE_MODEL];
        }else if(sender.tag == BUTTON_TAG_VIEW_PREFIX){
            _state = 1;
            [self loadData:CAR_HOME];
        }else if(sender.tag == BUTTON_TAG_VIEW_PREFIX+2){
            _state = 3;
            [self loadData:Beauty_DIARY];
        }
        
    }
}

- (IBAction)jingXuan:(id)sender {
    [self loadData:CAR_HOME];
    [_moveScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self moveAnimation:_jingXuanBtn];

}

- (IBAction)hotDiscussBtnClicked:(id)sender {
    [self loadHotDiscussData];
    [_moveScrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    [self moveAnimation:_hotDiscuss];
}

- (IBAction)usualDiscussBtnClicked:(id)sender {
    [self loadUsualDiscussData];
    [_moveScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:YES];
    [self moveAnimation:_usualDiscuss];
   
    
}

-(void)moveAnimation:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = _moveLine.frame;
        frame.origin.x = btn.frame.origin.x;
        frame.size.width = btn.frame.size.width;
        _moveLine.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)changeButtonColor:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo colorThree:(UIColor *)colorThree{
    [_jingXuanBtn setTitleColor:colorOne forState:UIControlStateNormal];
    [_hotDiscuss setTitleColor:colorTwo forState:UIControlStateNormal];
    [_usualDiscuss setTitleColor:colorThree forState:UIControlStateNormal];
}

@end
