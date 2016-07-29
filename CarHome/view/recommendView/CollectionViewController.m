//
//  CollectionViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CollectionViewController.h"
#import "WebDAO.h"
#import "WebVO.h"
#import "HeadView.h"
#import "WebViewController.h"
#import "ClubDetailViewController.h"
#import "ClubDetailDAO.h"
#import "ClubDetailVO.h"
@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    
    __weak IBOutlet UIView *topView;
    __weak IBOutlet UIButton *leftBtn;
    __weak IBOutlet UITableView *myTableView;
    NSMutableDictionary *headDic;
    NSArray * webList;
    NSArray * clubDetailList;
    NSMutableArray * dataList;
}

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    dataList = [[NSMutableArray alloc]init];
}
-(void)configUI{
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.tableFooterView = [[UIView alloc]init];
    myTableView.allowsMultipleSelectionDuringEditing = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

-(void)loadData{
    webList = [[[WebDAO alloc]init]findAll];
    clubDetailList = [[ClubDetailDAO new]findAll];
    for (int i = 0; i<2; i++) {
        if (i == 0) {
            NSMutableDictionary *newDic = [[NSMutableDictionary alloc]init];
            [newDic setObject:webList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"推荐" forKey:@"name"];
            [dataList addObject:newDic];
        }else if(i == 1){
            NSMutableDictionary *newDic = [[NSMutableDictionary alloc]init];
            [newDic setObject:clubDetailList forKey:@"content"];
            [newDic setObject:@0 forKey:@"isOpen"];
            [newDic setObject:@"论坛" forKey:@"name"];
            [dataList addObject:newDic];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (IBAction)clicked:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

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
- (IBAction)rigth1Click:(UIButton *)sender {
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
        WebVO * webVO = [WebVO new];
        ClubDetailVO *clubDetailVO = [ClubDetailVO new];
        if ([[cells[indexPath.row] class] isKindOfClass:[webVO class]]){
            webVO = cells[indexPath.row];
            [[[WebDAO alloc]init] dele:webVO];
        }else{
            clubDetailVO = cells[indexPath.row];
            [[[ClubDetailDAO alloc]init] dele:clubDetailVO];
        }
        [cells removeObjectAtIndex:indexPath.row];
        [myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
            [self deleteData];
    }
}
- (IBAction)right2Click:(UIButton *)sender {
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"确认要删除吗？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    alertView.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"myCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.section == 0) {
        WebVO * model = webList[indexPath.row];
        cell.textLabel.text = model.webString;
        return cell;
    }else{
        ClubDetailVO * model = clubDetailList[indexPath.row];
        cell.textLabel.text = model.pathString;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!tableView.editing) {
        if (indexPath.section == 0) {
            WebVO * model = [[WebVO alloc]init];
            model = webList[indexPath.row];
            WebViewController * WVC = [[WebViewController alloc]init];
            WVC.webString = model.webString;
            [self presentViewController:WVC animated:YES completion:nil];
        }else{
            ClubDetailVO * model = [[ClubDetailVO alloc]init];
            model = clubDetailList[indexPath.row];
            ClubDetailViewController * CDVC = [[ClubDetailViewController alloc]init];
            CDVC.webPath = model.pathString;
            [self presentViewController:CDVC animated:YES completion:nil];
        }
    }
}



@end
