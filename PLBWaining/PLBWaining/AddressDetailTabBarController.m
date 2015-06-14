//
//  AddressDetailTabBarController.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "AddressDetailTabBarController.h"
#import "BasicInfoViewController.h"
#import "CurrentInfoViewController.h"
#import "BightInfoViewController.h"
#import "HistoryInfoViewController.h"

@interface AddressDetailTabBarController ()

@end

@implementation AddressDetailTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutControllers];   //添加Controllers
    
}

//添加Controllers方法实现
-(void)layoutControllers{
    //基本信息
    BasicInfoViewController * basic = [[BasicInfoViewController alloc] init];
    UINavigationController * basicNC = [[UINavigationController alloc] initWithRootViewController:basic];
    [basicNC.tabBarItem setImage:[UIImage imageNamed:@"BasicInfo-64"]];
    basic.title = @"基本信息";
    
    //实时信息
    CurrentInfoViewController * current = [[CurrentInfoViewController alloc] init];
    UINavigationController * currentNC = [[UINavigationController alloc] initWithRootViewController:current];
    [currentNC.tabBarItem setImage:[UIImage imageNamed:@"Current-64"]];
    current.title = @"实时信息";
    
    //侵染曲线
    BightInfoViewController * bight = [[BightInfoViewController alloc] init];
    UINavigationController * bightNC = [[UINavigationController alloc] initWithRootViewController:bight];
    [bightNC.tabBarItem setImage:[UIImage imageNamed:@"Bight-64"]];
    bight.title = @"侵染曲线";
    
    //历史数据
    HistoryInfoViewController * historical = [[HistoryInfoViewController alloc] init];
    UINavigationController * historicalNC = [[UINavigationController alloc] initWithRootViewController:historical];
    [historicalNC.tabBarItem setImage:[UIImage imageNamed:@"History-64"]];
    historical.title = @"历史数据";
    
    //添加至tabBarController
    self.viewControllers = @[basicNC,currentNC,bightNC,historicalNC];
    self.selectedIndex = 0;
}


@end
