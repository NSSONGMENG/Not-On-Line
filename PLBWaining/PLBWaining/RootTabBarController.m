//
//  RootTabBarController.m
//  PLBWaining
//
//  Created by songmeng on 15/4/1.
//  Copyright (c) 2015年 songmeng. All rights reserved.
//

#import "RootTabBarController.h"
#import "AddressListTVC.h"
#import "MapVC.h"
#import "SettingVC.h"
#import "Define.h"
//#import "LoadBasicInfo.h"
//#import "SomeLoginView.h"
//#import "WaittingView.h"

@interface RootTabBarController ()
//<SomeLoginDelegate,UIAlertViewDelegate>
//@property (nonatomic,strong) UIScrollView   * scrollView;
//@property (nonatomic,strong) LoadBasicInfo  * loadData;
//@property (nonatomic,strong) UIImageView    * imageView;
//@property (nonatomic,strong) NSUserDefaults * user;
//@property (nonatomic,strong) SomeLoginView  * loginView;
//@property (nonatomic,assign) double      angle;     //角度
//@property (nonatomic,strong) UIImageView    * waittingView; //等待图片

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //地区列表
    AddressListTVC * address = [[AddressListTVC alloc] init];
    UINavigationController * addressNC = [[UINavigationController alloc] initWithRootViewController:address];
    addressNC.navigationBar.backgroundColor = [UIColor greenColor];
    [addressNC.tabBarItem setImage:[UIImage imageNamed:@"List-64"]];
    address.title = @"列表";
    
    //地图
    MapVC * map = [[MapVC alloc] init];
    UINavigationController * mapNC = [[UINavigationController alloc] initWithRootViewController:map];
    mapNC.navigationBar.backgroundColor = [UIColor greenColor];
    [mapNC.tabBarItem setImage:[UIImage imageNamed:@"Map-64"]];
    map.title = @"地图";
    
    //设置
    SettingVC * setting = [[SettingVC alloc] init];
    UINavigationController * settingNC = [[UINavigationController alloc] initWithRootViewController:setting];
    settingNC.navigationBar.backgroundColor = [UIColor greenColor];
    [settingNC.tabBarItem setImage:[UIImage imageNamed:@"Setting-64"]];
    setting.title = @"设置";
    
    self.viewControllers = @[addressNC,mapNC,settingNC];
    //默认显示地图页
    self.selectedIndex = 1;

    //注册通知，调整默认显示页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setSeletedAtIndex) name:@"setSeletedAtIndex" object:nil];
}


//重新登录后，页面跳转至Map View
- (void)setSeletedAtIndex{
    self.selectedIndex = 1;
}

@end
