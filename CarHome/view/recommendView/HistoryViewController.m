//
//  HistoryViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HistoryViewController.h"
#import "NewNew1DAO1.h"
#import "BulletinDAO1.h"
#import "videoDAO1.h"
#import "newsDAO1.h"
#import "TestDAO1.h"
#import "CarHomeDAO.h"
#include "HotDiscussDAO.h"
#import "ThemeDiscussDAO.h"
#import "NewNew1VO.h"
#import "BulletinVO.h"
#import "videoVO.h"
#import "TestVO.h"
#import "NewsVO.h"
#import "New1TableViewCell.h"
#import "New2TableViewCell.h"
#import "bulletinTableViewCell.h"
#import "HeadView.h"
#import "NSStringHelp.h"
#import "UIImageView+Remote.h"
#import "CarHomeModel.h"
#import "HotDiscuss.h"
#import "ThemeDiscussModel.h"
#import "ThemeDetailTableViewCell.h"
#import "HotDiscussTableViewCell.h"
#import "JingXuanTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface HistoryViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIButton *leftBtn;
    __weak IBOutlet UITableView *myTableView;
    __weak IBOutlet UIButton *right1Btn;
    __weak IBOutlet UIButton *right2Btn;
    NSMutableDictionary *headDic;
    NSArray * newNew1List;
    NSArray * BulletinList;
    NSArray * videoList;
    NSArray * newsList;
    NSArray * testList;
    NSArray * carHomeList;
    NSArray * hotDiscussList;
    NSArray * themeDiscussList;
    NSMutableArray * dataList;
}

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    newNew1List = [NSArray array];
    BulletinList = [NSArray array];
    videoList = [NSArray array];
    newsList = [NSArray array];
    testList = [NSArray array];
    carHomeList = [NSArray array];
    hotDiscussList = [NSArray array];
    themeDiscussList = [NSArray array];
    dataList = [NSMutableArray array];
}

-(void)configUI{
    myTableView.delegate =self;
    myTableView.dataSource =self;
    [myTableView registerNib:[UINib nibWithNibName:@"New1TableViewCell" bundle:nil] forCellReuseIdentifier:@"New1TableViewCell"];
    [myTableView registerNib:[UINib nibWithNibName:@"New2TableViewCell" bundle:nil] forCellReuseIdentifier:@"New2TableViewCell"];
    [myTableView registerNib:[UINib nibWithNibName:@"bulletinTableViewCell" bundle:nil] forCellReuseIdentifier:@"bulletinTableViewCell"];
    [myTableView registerNib:[UINib nibWithNibName:@"ThemeDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"ThemeDetailTableViewCell"];
    [myTableView registerNib:[UINib nibWithNibName:@"HotDiscussTableViewCell" bundle:nil] forCellReuseIdentifier:@"HotDiscussTableViewCell"];
    [myTableView registerNib:[UINib nibWithNibName:@"JingXuanTableViewCell" bundle:nil] forCellReuseIdentifier:@"JingXuanTableViewCell"];
    myTableView.tableFooterView  = [[UIView alloc]init];
    //开启多项选择
    myTableView.allowsMultipleSelectionDuringEditing = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

-(void)loadData{
    newNew1List = [[[NewNew1DAO1 alloc]init]findAll];
    BulletinList = [[[BulletinDAO1 alloc]init]findAll];
    videoList = [[[videoDAO1 alloc]init]findAll];
    newsList = [[[newsDAO1 alloc]init]findAll];
    testList = [[[TestDAO1 alloc]init]findAll];
    carHomeList = [[[CarHomeDAO alloc]init]findAll];
    hotDiscussList = [[[HotDiscussDAO alloc]init]findAll];
    themeDiscussList = [[[ThemeDiscussDAO alloc]init]findAll];
    for (int i = 0; i<8; i++) {
        if (i == 0) {
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:newNew1List forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"最新" forKey:@"name"];
            [dataList addObject:newDic];
        }else if(i == 1){
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:BulletinList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"快报" forKey:@"name"];
            [dataList addObject:newDic];
        }else if (i==2){
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:videoList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"视频" forKey:@"name"];
            [dataList addObject:newDic];
        }else if (i==3){
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:newsList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"新闻" forKey:@"name"];
            [dataList addObject:newDic];
        }else if (i==4){
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:testList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"评测" forKey:@"name"];
            [dataList addObject:newDic];
        }else if (i==5){
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:carHomeList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"精选日报" forKey:@"name"];
            [dataList addObject:newDic];
        }else if (i==6){
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:hotDiscussList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"热帖" forKey:@"name"];
            [dataList addObject:newDic];
        }else if (i==7){
            NSMutableDictionary * newDic = [NSMutableDictionary dictionary];
            [newDic setObject:themeDiscussList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"常用论坛" forKey:@"name"];
            [dataList addObject:newDic];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dic = dataList[section];
    if ([dic[@"isOpen"] boolValue]) {
        NSArray *array = dic[@"content"];
        return array.count;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NewNew1VO *model = dataList[0][@"content"][indexPath.row];
        if ([model.indexdetail containsString:@".jpg"]) {
            return 120;
        }else{
            return 70;
        }
    }else if(indexPath.section == 1){
        return 200;
    }else if (indexPath.section == 2){
        return 70;
    }else if (indexPath.section == 3){
        NewsVO*model =dataList[3][@"content"][indexPath.row];
        if ([model.indexdetail containsString:@".jpg"]) {
            return 120;
        }else{
            return 70;
        }
    }else if (indexPath.section == 4){
        return 70;
    }else if (indexPath.section == 5 || indexPath.section == 6 || indexPath.section == 7){
        return 60;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!headDic) {
        headDic = [NSMutableDictionary dictionary];
    }
    HeadView *head = [headDic objectForKey:@(section)];
    if (!head) {
        head = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
        [head setHeadTitle:[dataList[section] objectForKey:@"name" ]];
        [headDic setObject:head forKey:@(section)];
        head.openRow = ^{
            NSMutableDictionary *dic =  dataList[section];
            BOOL rec = [dic[@"isOpen"] boolValue];
            [dic setObject:@(!rec) forKey:@"isOpen"];
            [tableView reloadData];
            //刷新某一组或多组
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
            return !rec;
            
        };
    }
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//如果允许移动cell，实现了这个方法，在编辑状态就会出现三条杠，点到杠杠拖拽就可以移动cell
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    //在这里要交换数据源
    //原来的组
    NSDictionary *sourceDic = dataList[sourceIndexPath.section];
    NSDictionary *desDic = dataList[destinationIndexPath.section];
    
    //先从原来的地方删除
    NSMutableArray *sourceGroup = sourceDic[@"content"];
    //注意要先保存数据
    id obj = sourceGroup[sourceIndexPath.row];
    [sourceGroup removeObjectAtIndex:sourceIndexPath.row];
    
    //再插入到新的地方
    NSMutableArray *desGroup = desDic[@"content"];
    [desGroup insertObject:obj atIndex:destinationIndexPath.row];
}
- (IBAction)right1Click:(UIButton *)sender {
    if(sender.tag == 0)
    {
        [myTableView setEditing:YES animated:YES];
    }
    else
    {
        [myTableView setEditing:NO animated:YES];
    }
    sender.tag = !sender.tag;
}

-(void)deleteData{
    //拿到选中的所有行
    //储存的是indexPath
    NSArray *array = [myTableView indexPathsForSelectedRows];
    
    //将indexPath排序
    NSArray *newIndexPath = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSIndexPath *)obj1 compare:obj2];
    }];
    
    //删除数据源
    //从后面往前面删
    for (NSInteger i = newIndexPath.count -1; i>=0; i--) {
        //取到一个cell对应的indexPath
        NSIndexPath *indexPath = newIndexPath[i];
        //取到对应的数据源的分组
        NSDictionary *group = dataList[indexPath.section];
        //取到cell所在的分组数据的数组
        NSMutableArray *cells = (NSMutableArray *)group[@"content"];
        NewNew1VO * newNew1VO = [NewNew1VO new];
        BulletinVO *bulletinVO = [BulletinVO new];
        videoVO *videovo = [videoVO new];
        TestVO * testVO = [TestVO new];
        NewsVO *newsVO = [NewsVO new];
        CarHomeModel * carHomeModel = [CarHomeModel new];
        HotDiscuss * hotDiscuss = [HotDiscuss new];
        ThemeDiscussModel * themeDiscuss = [ThemeDiscussModel new];
        if ([[cells[indexPath.row] class] isKindOfClass:[newNew1VO class]]) {
            newNew1VO = cells[indexPath.row];
            [[[NewNew1DAO1 alloc]init] dele:newNew1VO];
        }else if([[cells[indexPath.row] class] isKindOfClass:[bulletinVO class]]){
            bulletinVO = cells[indexPath.row];
            [[[BulletinDAO1 alloc]init] dele:bulletinVO];
        }else if ([[cells[indexPath.row] class] isKindOfClass:[videovo class]]){
            videovo = cells[indexPath.row];
            [[[videoDAO1 alloc]init] dele:videovo];
        }else if ([[cells[indexPath.row] class] isKindOfClass:[testVO class]]){
            testVO = cells[indexPath.row];
            [[[TestDAO1 alloc]init] dele:testVO];
        }else if([[cells[indexPath.row] class] isKindOfClass:[newsVO class]]){
            newsVO = cells[indexPath.row];
            [[[newsDAO1 alloc]init] dele:newsVO];
        }else if ([[cells[indexPath.row] class] isKindOfClass:[carHomeModel class]]){
            carHomeModel = cells[indexPath.row];
            [[[CarHomeDAO alloc]init] dele:carHomeModel
             ];
        }else if ([[cells[indexPath.row] class] isKindOfClass:[hotDiscuss class]]){
            hotDiscuss = cells[indexPath.row];
            [[[HotDiscussDAO alloc]init] dele:hotDiscuss];
        }else{
            themeDiscuss = cells[indexPath.row];
            [[[ThemeDiscussDAO alloc]init] dele:themeDiscuss];
        }
        //把cell对应的数据从数组中删掉
        [cells removeObjectAtIndex:indexPath.row];
        [myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [self deleteData];
    }
}

- (IBAction)right2Click:(id)sender {
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"确认要删除吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    alertView.delegate = self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NewNew1VO * model = newNew1List[indexPath.row];
        if ([model.indexdetail containsString:@".jpg"]) {
            New2TableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"New2TableViewCell" forIndexPath:indexPath];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
            //图片
            NSArray *arr = [[[NSStringHelp alloc]init]photoString:model.indexdetail];
            if (arr[0]) {
                [cell.iconImage1 setImageWithURLString:arr[0]];
            }
            if (arr[1]) {
                [cell.iconImage2 setImageWithURLString:arr[1]];
            }
            if (arr[2]) {
                [cell.iconImage3 setImageWithURLString:arr[2]];
            }
            cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
            if (model.type.length>1) {
                cell.decriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
            }
            return cell;
        }else{
            New1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"New1TableViewCell"forIndexPath:indexPath];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
            [cell.iconImage setImageWithURLString:model.smallpic];
            cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
            if (model.type.length>1){
                cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
            }
            return cell;
        }
    }else if (indexPath.section == 1){
        BulletinVO * model = BulletinList[indexPath.row];
        bulletinTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bulletinTableViewCell" forIndexPath:indexPath];
        cell.typenameLabel.text = [NSString stringWithFormat:@"%@",model.appTypename];
        if (model.state.intValue ==1) {
            cell.stateLabel.text = @"正在直播";
        }else{
            cell.stateLabel.text = @"播报结束";
        }
        cell.titlelabel.text = [NSString stringWithFormat:@"%@",model.title];
        cell.reviewcountLabel.text = [NSString stringWithFormat:@"%@位观众",model.reviewcount];
        [cell.iconImage setImageWithURLString:model.bgimage];
        cell.advancetimeLabel.text = [NSString stringWithFormat:@"%@",model.advancetime];
        return cell;
    }else if (indexPath.section == 2){
        videoVO *model = videoList[indexPath.row];
        New1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"New1TableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
        [cell.iconImage setImageWithURLString:model.smallimg];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
        return cell;
    }else if (indexPath.section == 3){
        NewsVO * model = newsList[indexPath.row];
        if ([model.indexdetail containsString:@".jpg"]) {
            New2TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"New2TableViewCell" forIndexPath:indexPath];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
            //图片
            NSArray *arr = [[[NSStringHelp alloc]init]photoString:model.indexdetail];
            if (arr[0]) {
                [cell.iconImage1 setImageWithURLString:arr[0]];
            }
            if (arr[1]) {
                [cell.iconImage2 setImageWithURLString:arr[1]];
            }
            if (arr[2]) {
                [cell.iconImage3 setImageWithURLString:arr[2]];
            }
            cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
            if (model.type.length>1){
                cell.decriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
            }
            return cell;
        }else{
            New1TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"New1TableViewCell"forIndexPath:indexPath];
            cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
            [cell.iconImage setImageWithURLString:model.smallpic];
            cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
            if (model.type.length>1){
                cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
            }
            return cell;
        }
    }else if (indexPath.section == 4){
        TestVO * model = testList[indexPath.row];
        New1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"New1TableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
        [cell.iconImage setImageWithURLString:model.smallpic];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",model.time];
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@",model.type];
        return cell;
    }else if (indexPath.section == 5){
        JingXuanTableViewCell * jingHuaCell = [tableView dequeueReusableCellWithIdentifier:@"JingXuanTableViewCell" forIndexPath:indexPath];
        CarHomeModel * model = carHomeList[indexPath.row];
        [jingHuaCell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.smallpic]placeholderImage:[UIImage imageNamed:@"carback"]];
        jingHuaCell.nameLabel.text = model.title;
        jingHuaCell.detailLabel.text = model.bbsname;
        jingHuaCell.answerLabel.text = [NSString stringWithFormat:@"%@回帖",model.replycounts];
        return jingHuaCell;
    }else if (indexPath.section == 6){
        HotDiscussTableViewCell * hotdiscussCell = [tableView dequeueReusableCellWithIdentifier:@"HotDiscussTableViewCell" forIndexPath:indexPath];
        HotDiscuss * model = hotDiscussList[indexPath.row];
        hotdiscussCell.titleLabel.text = model.title;
        hotdiscussCell.timeLabel.text = [NSString stringWithFormat:@"%@ %@",model.bbsname,model.postdate];
        hotdiscussCell.replyLabel.text = [NSString stringWithFormat:@"%@回帖",model.replycounts];
        NSNumber * nu =  model.ispictopic;
        if([nu intValue]){
            hotdiscussCell.picImagView.image = [UIImage imageNamed:@"forum_icon_pic"];
        }
        return hotdiscussCell;
    }else if (indexPath.section == 7){
        ThemeDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ThemeDetailTableViewCell" forIndexPath:indexPath];
        ThemeDiscussModel * model = themeDiscussList[indexPath.row];
        cell.titleLabel.text = model.title;
        cell.timeLabel.text = [NSString stringWithFormat:@"回复:%@", model.lastreplydate];
        cell.replyLabel.text = [NSString stringWithFormat:@"%@ %@回",model.postusername,model.replycounts];
        if(model.ispic.intValue){
            cell.picImageView.image = [UIImage imageNamed:@"forum_icon_pic"];
        }
        if([model.topictype isEqualToString:@"精"]){
            cell.jingImageView.image = [UIImage imageNamed:@"forum_icon_fine"];
        }else if ([model.topictype isEqualToString:@"顶"]){
            cell.jingImageView.image = [UIImage imageNamed:@"forum_icon_top"];
        }else if ([model.topictype isEqualToString:@"问"]){
            cell.jingImageView.image = [UIImage imageNamed:@"forum_icon_question_ed"];
        }
        return cell;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    }

- (IBAction)Clicked:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
