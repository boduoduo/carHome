//
//  HomeViewController.m
//  CarHome
//
//  Created by qianfeng on 15/10/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HomeViewController.h"
//#import "RecommendViewController.h"
//#import "DiscussViewController.h"
//#import "LookingViewController.h"
//#import "MyCollectionTableViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configUI{
    self.tabBar.backgroundColor = [UIColor redColor];
    UIStoryboard * recommendSB = [UIStoryboard storyboardWithName:@"Recommend" bundle:nil];
    UIViewController * recommendVC = [recommendSB instantiateInitialViewController];
    recommendVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"推荐" image:[[UIImage imageNamed:@"nav_meizu_icon_article"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"nav_meizu_icon_article_c"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIStoryboard * discussSB = [UIStoryboard storyboardWithName:@"Discuss" bundle:nil];
    UIViewController * discussVC = [discussSB instantiateInitialViewController];
    discussVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"论坛" image:[[UIImage imageNamed:@"nav_meizu_icon_forum"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"nav_meizu_icon_forum_c"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIStoryboard * lookingSB = [UIStoryboard storyboardWithName:@"Looking" bundle:nil];
    UIViewController * lookingVC = [lookingSB instantiateInitialViewController];
    lookingVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"找车" image:[[UIImage imageNamed:@"nav_meizu_icon_car"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"nav_meizu_icon_car_c"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UIStoryboard * mycollectionSB = [UIStoryboard storyboardWithName:@"MyCollection" bundle:nil];
    UIViewController * mycollectionVC = [mycollectionSB instantiateInitialViewController];
    mycollectionVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我" image:[[UIImage imageNamed:@"nav_meizu_icon_user"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] selectedImage:[[UIImage imageNamed:@"nav_meizu_icon_user_c"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[recommendVC,discussVC,lookingVC,mycollectionVC];
    self.tabBar.tintColor=[UIColor colorWithRed:0.1463 green:0.565 blue:1.0 alpha:1.0];
    self.tabBar.barTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
